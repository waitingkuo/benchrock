# benchrock

I'd like to build a simple tool to make benchmark easier. I plan to build the images for some common benchmark tools (ex.wrk). Build some example for some web frameworks and some databases. So that I can use a simple yml file to setup my benchmark plan across multiple services provider (aws, digitalocean, azure) and then run it by something like `benchrock up`. The yml should look like:

    benchmark: wrk
    targets:
      - flask-example
      - rails-example
      - python-example
      - go-example
    machines:
      - mymachine1
      - mymachine2
      - mymachine3

Benchmark & targetss should be the images on dockerhub. Hosts should be the machine name listed in the docker-machine.
