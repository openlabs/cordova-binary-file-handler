cordova-binary-file-handler
============
Cordova plugin for downloading base64 data as binary file.

* `Installation <#installation>`_
* `Download base64 as binary <#download-base64-as-binary>`_
* `Show downloaded file in preview <#show-downloaded-file-in-preview>`_
* `Authors and Contributors <#authors-and-contributors>`_
* `Professional Support <#show-downloaded-file-in-preview>`_

Installation
------------
Get the latest code from github and install::

    cordova plugin add https://github.com/openlabs/cordova-binary-file-handler

Download base64 as binary
-------------------------
This plugin will add a global function ``writeTofile`` which can be used to save the base64
file as a binary to the filesystem. In success callback you can get the URI of the binary file
saved in the filesystem.

.. code-block:: js

  writeTofile(fileName, base64Data, successCallback, ErrorCallback);

===============  =======================================
fileName         The name you want to save your file as.
base64Data       base64Data which needs to be saved as binary.
successCallback  Success callback to get file path of saved file.
errorCallback    Callback for handling error.
===============  =======================================

.. code-block:: js

  writeTofile('filename.pdf', base64Data, function(filePath) {
    // Successfully saved base64Data as binary.
    console.log('Your file is stored at', filePath);
  }, function() {
    // Error
  });


Show downloaded file in preview
-------------------------------
This plugin can also be used for previewing the downloaded file inside your cordova app.

Opening the file can come handy for printing it or for opening it in an external app.
For example open a pdf with acrobat reader, chrome or just print it directly.

A global function ``quickLookFile`` is added which takes file URI and opens it in preview
inside your app.

.. code-block:: js

  quickLookFile(fileURI, successCallBack, errorCallback);

===============  =======================================
fileURI          Path of file on the file system.
successCallback  Success callback
errorCallback    Callback for handling error.
===============  =======================================

Authors and Contributors
------------------------

This plugin was built at `Openlabs <http://www.openlabs.co.in>`_. 

Professional Support
--------------------

This plugin is professionally supported by `Openlabs <http://www.openlabs.co.in>`_.
If you are looking for on-site teaching or consulting support, contact our
`sales <mailto:sales@openlabs.co.in>`_ and `support
<mailto:support@openlabs.co.in>`_ teams.
