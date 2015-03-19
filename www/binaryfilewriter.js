var exec = require('cordova/exec');

var BinaryFileWriter = {
  writeToFile: function(path, base64data, success, error) {
    cordova.exec(success, error, "BinaryFileWriter", "writeToFile", [path, base64data]);
  },
  quickLookFile: function(path, success, error) {
    cordova.exec(success, error, "BinaryFileWriter", "quickLookFile", [path]);
  }
};

module.exports = BinaryFileWriter;
window.writeToFile = BinaryFileWriter.writeToFile;
window.quickLookFile = BinaryFileWriter.quickLookFile;
