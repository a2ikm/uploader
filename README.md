Uploader
========

A naive file uploader.

How to use
----------

Clone this repository and execute uploader.rb.

```console
$ ruby uploader.rb
```

Or curl and execute it.

```console
$ curl -sL https://git.io/uploaderrb | ruby -
```

Then, open http://localhost:4567 and upload a file.
It will be uploaded to `upload` directory by default.

### Options

```console
$ ruby uploader.rb --help
Usage: uploader [options]
    -p, --port NUMBER
    -u, --upload DIRECTORY
```
