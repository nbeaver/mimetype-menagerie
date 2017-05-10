======================
The Mimetype Menagerie
======================

-----
Goals
-----

A single repository with an example file for every mimetype.

----
Why?
----

Because examples are useful and file extensions are unreliable.

--------
Criteria
--------

In order of priority:

#. Public domain or Creative Commons licensing.
#. Correctly represents the mimetype.
#. Stable URIs (permalinks are best).
#. Relatively small file size (to save disk space and bandwidth).

-----------------
Is that possible?
-----------------

The IANA lists `about 1700 registered mimetypes`_,
some of which are deprecated or duplicates.
There are many more which are unofficial.

It's a big job, but not impossible.
See the `coverage report`_ for details.

.. _about 1700 registered mimetypes: https://www.iana.org/assignments/media-types/media-types.xhtml
.. _coverage report: coverage_report.txt

---------------
Example usecase
---------------

Suppose you want an example of a VRML file.

`Wikipedia discusses VRML`_ and links to examples,
but finding an actual VRML file via web search is non-trivial.

A Google filetype search for ``.vrml`` files? Not helpful.

https://google.com/search?q=filetype%3Avrml

Oops, that should be ``.wrl`` files.

https://google.com/search?q=filetype%3Awrl

But most of the results still aren't relevant.

Even if you find a good link,
you either have to keep track of the file
or bookmark the link,
which could give a 404 the next time you open it.

.. _Wikipedia discusses VRML: https://en.wikipedia.org/wiki/VRML

With a mimetype menagerie,
it's as simple as a link to a directory:

`<media-types/model/vrml/>`_

And finding files from scratch
is a simple search with a file manager
or on the commandline like this::

    $ cd media-types/
    $ find . -iname '*VRML*'
    ./model/vrml
    $ ls model/vrml/
    HelloWorld.wrl

-----
Notes
-----

Some mimetypes may not have any public domain examples,
or may be patent-encumbered.
These can be linked to,
but will have to be omitted from the actual git repository.

----------------
Similar projects
----------------

The fuzzing program American Fuzzy Lop (afl)
has a number of testcases,
such as archives and image formats:

https://github.com/loverszhaokai/AFL/tree/master/testcases

The FFMPEG project has a compendium of video files,
though it's unclear how many are public domain.

http://samples.ffmpeg.org/
