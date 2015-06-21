Meteor.startup ->

 
  exec = Npm.require('child_process').exec
  Meteor.methods

    'wrk': (images, machines)->
      if images.length == 0 or machines.length == 0
        return {}
      for image in images
        for machine in machines
          console.log image, machine
          runCmd = Meteor.wrapAsync(exec)
          ip = runCmd('docker-machine ip ' + machine).trim()
          config = runCmd('docker-machine config ' + machine).trim()
          containerId = runCmd('docker ' +config+' run -d -p 1212:80 ' + image).trim()

          Meteor.sleep(1000)
          result = runCmd('wrk -d1s http://'+ip+':1212')
          lines = result.split '\n'
          latency = lines[3].trim().split(/\s+/)[1]
          threadReq = lines[4].trim().split(/\s+/)[1]
          req = lines[6].trim().split(/\s+/)[1]
          #console.log latency, req

          runCmd('docker ' +config+' kill ' + containerId).trim()
          Results.insert
            image: image
            machine: machine
            latency: latency
            req: req

     
      return {}

