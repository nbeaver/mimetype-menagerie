======================
The Mimetype Menagerie
======================

-----
Goals
-----

At least one valid, representative file for every mimetype.

--------
Criteria
--------

In order of priority:

#. Public domain or Creative Commons licensing.
#. Correctly represents the mimetype.
#. Relatively small file size (to save disk space and bandwidth).
#. Stable URI (permalinks are best).

-----------------
Is that possible?
-----------------

The IANA lists `about 1500 registered mimetypes`_,
some of which are deprecated.
There are many more which are unofficial.

It's a big job, but not impossible.

.. about 1500 registered mimetypes: https://www.iana.org/assignments/media-types/media-types.xhtml

----
Why?
----

A reference library of examples of filetypes is useful,
and the amount of required disk space
is quite reasonable on modern hard drives.

---------------
Example usecase
---------------

Suppose you want an example of a `VRML`_ file.
With a mimetype menagerie, it's as simple as

::

    $ find . -iname VRML
    ./media-types/model/vrml
    $ ls media-types/model/vrml/
    HelloWorld.wrl

Finding an actual VRML file via web search
is difficult by comparison.

`Wikipedia discusses VRML`_ and links to examples,
but has no actual VRML files.

How about a Google filetype search?

https://google.com/search?q=filetype%3Avrml

Oops, that should be ``.wrl`` files.

https://google.com/search?q=filetype%3Awrl

But most of the results aren't relevant.
And even if you find a good link,
you either have to keep track of the file
or bookmark the link,
which could give a 404 the next time you open it.

.. Wikipedia discusses VRML: https://en.wikipedia.org/wiki/VRML

-----
Notes
-----

Some mimetypes may not have any public domain examples,
or may be patent-encumbered.
These can be linked to,
but will have to be omitted from the actual git repository.
