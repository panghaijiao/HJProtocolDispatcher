# HJProtocolDispatcher

![](https://img.shields.io/badge/build-passing-brightgreen.svg)
![](https://img.shields.io/badge/pod-v0.4.1-blue.svg)
![](https://img.shields.io/badge/language-objc-5787e5.svg)
![](https://img.shields.io/badge/license-MIT-brightgreen.svg)  

A tool to dispatch protocol to multiple implemertors

## How To Use

```
self.tableView.delegate = AOProtocolDispatcher(UITableViewDelegate, self, self.delegateSource);
```

## Installation with CocoaPods

[CocoaPods](http://cocoapods.org/) is a dependency manager for Objective-C, which automates and simplifies the process of using 3rd-party libraries in your projects. See the [Get Started](http://cocoapods.org/#get_started) section for more details.

## Podfile

```
pod 'HJProtocolDispatcher',    :git => 'https://github.com/panghaijiao/HJProtocolDispatcher.git'
```


## License

HJProtocolDispatcher is released under the MIT license. See LICENSE for details.
Copyright owner [Alessandroorru](https://github.com/alessandroorru/AOMultiproxier)

