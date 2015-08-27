/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 */
'use strict';

var React = require('react-native');
var {
  AppRegistry,
  StyleSheet,
  Text,
  View,
} = React;

var DeviceMotion = require('./DeviceMotion.ios.js');

var DeviceMotionExample = React.createClass({
  getInitialState: function () {
    return {
      motionData: null
    };
  },

  componentDidMount: function () {
    DeviceMotion.startDeviceMotionUpdates(1000/60, (data) => {
      this.setState({
        motionData: data,
      });
    });
  },

  render: function() {
    var motionData = this.state.motionData;

    return (
      <View style={styles.container}>
        <Text style={styles.welcome}>
          Device Motion for React Native
        </Text>
        <Text style={styles.instructions}>
          This app shows three bars below corresponding to roll, pitch and yaw of the device.
        </Text>
        {this.state.motionData ? 
          <View>
            <View style={{backgroundColor: 'red', height: 10, width: (motionData.attitude.roll+1)*100}} />
            <View style={{backgroundColor: 'green', height: 10, width: (motionData.attitude.pitch+1)*100}} />
            <View style={{backgroundColor: 'blue', height: 10, width: (motionData.attitude.yaw+1)*100}} />
          </View> 
          : null}
        <Text style={styles.instructions}>
          Make sure you try this out on an iOS device. No motion data in Simulator.
        </Text>
      </View>
    );
  }
});

var styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: 'center',
    // alignItems: 'center',
    backgroundColor: '#F5FCFF',
  },
  welcome: {
    fontSize: 20,
    textAlign: 'center',
    margin: 10,
  },
  instructions: {
    textAlign: 'center',
    color: '#333333',
    marginBottom: 5,
  },
});

AppRegistry.registerComponent('RNTDeviceMotion', () => DeviceMotionExample);
