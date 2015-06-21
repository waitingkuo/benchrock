Meteor.startup ->

 
  exec = Npm.require('child_process').exec
  Meteor.methods

    wrkInit: (images, machines, options) ->
      if images.length == 0 or machines.length == 0
        return {}
      wrkId = Wrks.insert {images:images, machines:machines, options: options}
      return {wrkId: wrkId}

    wrkRun: (wrkId)->
      wrk = Wrks.findOne wrkId
      if not wrk?
        return
      
      for image in wrk.images
        for machine in wrk.machines
          console.log image, machine
          runCmd = Meteor.wrapAsync(exec)
          ip = runCmd('docker-machine ip ' + machine).trim()
          config = runCmd('docker-machine config ' + machine).trim()
          #FIXME a hack
          #if image == 'joshyoung360/expressbase'
          #  containerId = runCmd('docker ' +config+' run -d -p 1212:3000 ' + image).trim()
          #else
          containerId = runCmd('docker ' +config+' run -d -p 1212:80 ' + image).trim()

          Meteor.sleep(3000)
          if wrk.options is undefined
            result = runCmd('wrk http://'+ip+':1212')
          else
            result = runCmd('wrk '+ wrk.options + ' http://'+ip+':1212')
          lines = result.split '\n'
          latency = lines[3].trim().split(/\s+/)[1]
          threadReq = lines[4].trim().split(/\s+/)[1]
          req = lines[6].trim().split(/\s+/)[1]
          if req == 'errors:'
            req = lines[7].trim().split(/\s+/)[1]
          #console.log latency, req

          runCmd('docker ' +config+' kill ' + containerId).trim()
          WrkResults.insert
            wrkId: wrkId
            image: image
            machine: machine
            latency: latency
            req: req
          Meteor.sleep(1000)

     

