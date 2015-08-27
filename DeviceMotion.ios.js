'use strict'

var React = require('react-native');
var {
  NativeModules,
  DeviceEventEmitter,
} = React;

var RNTDeviceMotion = NativeModules.RNTDeviceMotion;

function startDeviceMotionUpdates(updateInterval, callback) {
  RNTDeviceMotion.startDeviceMotionUpdatesWithUpdateInterval(updateInterval || 1000/10);
  DeviceEventEmitter.addListener('onDeviceMotionUpdate', callback);
};

function stopDeviceMotionUpdates () {
  RNTDeviceMotion.stopDeviceMotionUpdates();
  DeviceEventEmitter.removeAllListeners('onDeviceMotionUpdate');
}

var DeviceMotion = {
  startDeviceMotionUpdates,
  stopDeviceMotionUpdates
};

module.exports = DeviceMotion;