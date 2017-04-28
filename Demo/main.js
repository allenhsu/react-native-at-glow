/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 * @flow
 */

import React, { Component } from 'react';
import {
  AppRegistry,
  StyleSheet,
  Text,
  View,
  TouchableOpacity,
  NativeModules,
} from 'react-native';

var NativeNavigator = NativeModules.NativeNavigator;

type Props = {
  i: number,
  j: number,
}

export default class GLReactNative extends Component {
  props: Props;
  constructor(props: Props) {
    super(props)
  }
  static defaultProps = {
    ...Component.defaultProps,
    i: 0,
    j: 0,
  }
  openURL(url: string, options: Object = {}) {
    NativeNavigator.openURL(url, options);
  }
  showURL(url: string, props: Object = {}, options: Object = {}) {
    NativeNavigator.showURL(url, props, options);
  }
  pushURL(url: string, props: Object = {}, options: Object = {}) {
    NativeNavigator.pushURL(url, props, options);
  }
  presentURL(url: string, props: Object = {}, options: Object = {}) {
    NativeNavigator.presentURL(url, props, options);
  }
  popOrDismiss() {
    NativeNavigator.popOrDismiss();
  }
  render() {
    if (this.props.url == '/some_module') {
      return (
        <View style={styles.container}>
          <Text style={styles.welcome}>
            I'm a special module
          </Text>
          <View style={styles.buttons}>
            <TouchableOpacity onPress={() => { this.popOrDismiss() }}>
              <Text style={styles.button}>Pop or dismiss</Text>
            </TouchableOpacity>
            <TouchableOpacity onPress={() => { this.openURL('https://glowing.com') }}>
              <Text style={styles.button}>Open URL</Text>
            </TouchableOpacity>
          </View>
        </View>
      )
    }
    return (
      <View style={styles.container}>
        <Text style={styles.welcome}>
          Glow React Native page #{this.props.j}-{this.props.i}
        </Text>
        <View style={styles.buttons}>
          <TouchableOpacity onPress={() => { this.showURL('/', {i: this.props.i + 1, j: this.props.j})}}>
            <Text style={styles.button}>Show/Push next page</Text>
          </TouchableOpacity>
          <TouchableOpacity onPress={() => { this.presentURL('/', {i: 0, j: this.props.j + 1})}}>
            <Text style={styles.button}>Present next page</Text>
          </TouchableOpacity>
          <TouchableOpacity onPress={() => { this.presentURL('/some_module', {i: 0, j: this.props.j + 1})}}>
            <Text style={styles.button}>Present some special module</Text>
          </TouchableOpacity>
          <TouchableOpacity onPress={() => { this.popOrDismiss() }}>
            <Text style={styles.button}>Pop or dismiss</Text>
          </TouchableOpacity>
          <TouchableOpacity onPress={() => { this.openURL('https://glowing.com') }}>
            <Text style={styles.button}>Open URL</Text>
          </TouchableOpacity>
        </View>
      </View>
    );
  }
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
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
  button: {
    marginBottom: 10,
    borderWidth: 1,
    borderRadius: 5,
    borderColor: '#dddddd',
    backgroundColor: 'white',
    paddingVertical: 5,
    paddingHorizontal: 10,
    textAlign: 'center',
  },
  footer: {
    position: 'absolute',
    padding: 25,
    left: 0,
    right: 0,
    bottom: 0,
    justifyContent: 'center',
    alignItems: 'center',
  },
});

AppRegistry.registerComponent('main', () => GLReactNative);
