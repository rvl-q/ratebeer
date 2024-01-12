# README

Deployed to fly.io at:
[https://biiru.fly.dev](https://biiru.fly.dev)

[![Maintainability](https://api.codeclimate.com/v1/badges/e75a3f7b44ef139f2ad5/maintainability)](https://codeclimate.com/github/rvl-q/ratebeer/maintainability)

## Build problems on fly.io 2023-11-28

[Failed github action](https://github.com/rvl-q/ratebeer/actions/runs/7024560623/job/19113564332)

### Fixed by Destroying builder(!)

Log:

```(text)
rvl@SulonKastike:~/kod/ror/wepa/ratebeer$ fly deploy
==> Verifying app config
Validating /home/rvl/kod/ror/wepa/ratebeer/fly.toml
Platform: machines
✓ Configuration is valid
--> Verified app config
==> Building image
WARN Remote builder did not start in time. Check remote builder logs with `flyctl logs -a fly-builder-wandering-dust-842`

WARN Failed to start remote builder heartbeat: remote builder app unavailable

WARN Remote builder did not start in time. Check remote builder logs with `flyctl logs -a fly-builder-wandering-dust-842`

Error: failed to fetch an image or build from source: error connecting to docker: remote builder app unavailable
rvl@SulonKastike:~/kod/ror/wepa/ratebeer$ fly apps destroy fly-builder-wandering-dust-842
Destroying an app is not reversible.
? Destroy app fly-builder-wandering-dust-842? Yes
Destroyed app fly-builder-wandering-dust-842
rvl@SulonKastike:~/kod/ror/wepa/ratebeer$ fly deploy
==> Verifying app config
Validating /home/rvl/kod/ror/wepa/ratebeer/fly.toml
Platform: machines
✓ Configuration is valid
--> Verified app config
==> Building image
Remote builder fly-builder-small-silence-9851 ready
==> Building image with Docker
--> docker host: 20.10.12 linux x86_64
[+] Building 50.3s (22/22) FINISHED

...

image size: 328 MB

Watch your deployment at https://fly.io/apps/biiru/monitoring

-------
Updating existing machines in 'biiru' with rolling strategy

-------
 ✔ [1/2] Machine 6e824113ce0938 [app] update succeeded
 ✔ [2/2] Machine e2865537c55228 [app] update succeeded
-------

Visit your newly deployed app at https://biiru.fly.dev/
rvl@SulonKastike:~/kod/ror/wepa/ratebeer$
```

### Kill VM - long live the VM(!)
