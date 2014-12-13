# What is this folder?

When running the tests, film snob will make a bunch of web requests to the
various supported oembed endpoints. film snob uses [vcr][] to save the responses
from those requests in this folder, so it doesn't need to make those requests
more than once on any given machine; on the second run it will notice it has a
cassette (really just a big yml file) and read that instead of going out to the
web again.

[vcr]: https://github.com/vcr/vcr

If tests suddenly start failing, it might mean that an example video has been
deleted. In that case, I guess we'll just swap out for a different video.

