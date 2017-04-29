/**
 * @flow
 */

import React from 'react';
import {
  NativeEventEmitter,
  NativeModules,
  Platform,
} from 'react-native';

import EventEmitter from 'EventEmitter';

var NativePubSub = NativeModules.PubSubEmitter;

export type PubSubHandler = (data?: Object) => void;

const PUBSUB_TAG_KEY = '_pubsub_tag';

class PubSubEmitter extends NativeEventEmitter {
  latestTag: number
  eventEmitter: EventEmitter

  contextMapping : {[tag:string]: {[name:string]: Array<PubSubHandler>}} = {}

  constructor() {
    super(NativePubSub);
    this.latestTag = 0;
    this.eventEmitter = new EventEmitter();
    this.addListener(
      'newEvent',
      this.didReceiveNewEvent.bind(this)
    )
  }

  didReceiveNewEvent(event: Object) {
    const { name, data } = event;
    this.eventEmitter.emit(name, data);
  }

  _keyForContext(context: Object): ?string {
    if (!context) {
      return null;
    }
    if (!context[PUBSUB_TAG_KEY]) {
      context[PUBSUB_TAG_KEY] = ++this.latestTag
    }
    return context[PUBSUB_TAG_KEY];
  }

  publish(name: string, data: Object) {
    if (Platform.OS == 'ios') {
      // Use native event to blast to all bridges on iOS
      this.publishNativeEvent(name, data);
    } else {
      // Only emit event in JS on Android
      this.eventEmitter.emit(name, data);
    }
  }

  publishNativeEvent(name: string, data: Object) {
    NativePubSub.publishEvent(name, data);
  }

  subscribe(context: Object, name: string, callback: PubSubHandler) {
    let key = this._keyForContext(context);
    if (!key || !name) {
      return;
    }
    NativePubSub.subscribeEvent(name);
    if (this.contextMapping[key] == undefined) {
      this.contextMapping[key] = {};
    }
    if (this.contextMapping[key][name] == undefined) {
      this.contextMapping[key][name] = [];
    }
    this.contextMapping[key][name].push(callback);
    this.eventEmitter.addListener(name, callback);
  }

  unsubscribe(context: Object, name?: string) {
    let key = this._keyForContext(context);
    if (!key) {
      return;
    }
    let mappings = this.contextMapping[key] || {};
    if (name == undefined) {
      let names = Object.keys(mappings);
      names.forEach((n) => {
        this.unsubscribe(context, n);
      });
      return;
    }
    let funcs = mappings[name] || [];
    funcs.forEach((callback) => {
      NativePubSub.unsubscribeEvent(name);
      this.eventEmitter.removeListener(name, callback);
    });
    if (this.contextMapping[key] != undefined) {
      delete this.contextMapping[key][name];
      if (Object.keys(this.contextMapping[key]).length == 0) {
        delete this.contextMapping[key];
      }
    }
  }
}

var PubSub = new PubSubEmitter();

export default PubSub;