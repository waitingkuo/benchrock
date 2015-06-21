Meteor.startup ->

 
  exec = Npm.require('child_process').exec
  Meteor.methods

    wrkInit: (images, machines) ->
      if images.length == 0 or machines.length == 0
        return {}
      wrkId = Wrks.insert {images:images, machines:machines}
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
          containerId = runCmd('docker ' +config+' run -d -p 1212:80 ' + image).trim()

          Meteor.sleep(1000)
          result = runCmd('wrk  http://'+ip+':1212')
          lines = result.split '\n'
          latency = lines[3].trim().split(/\s+/)[1]
          threadReq = lines[4].trim().split(/\s+/)[1]
          req = lines[6].trim().split(/\s+/)[1]
          #console.log latency, req

          runCmd('docker ' +config+' kill ' + containerId).trim()
          WrkResults.insert
            wrkId: wrkId
            image: image
            machine: machine
            latency: latency
            req: req

     

