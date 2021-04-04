# cons

A new Flutter package project.

## Getting Started

这是一个用于获取本地assets配置文件的工具.

注意此项目已依赖了yaml: ^3.1.0

[github项目主页地址](https://github.com/2628748861/configuration)

使用方法:

安装依赖:

```
dependencies:
  flutter_package_frode: xx
```


1.新建配置文件: assets/files/config.yaml
```
DEV:
  HOST: 'http://www.dev.com'
  WEICHAT:
    APPID: 'as232ewe'
    SECRET: 123
TEST:
  HOST: 'http://www.test.com'
  WEICHAT:
    APPID: 'bs232ewe'
    SECRET: 456
PRODUCT:
  HOST: 'http://www.product.com'
  WEICHAT:
    APPID: 'cs232ewe'
    SECRET: 789
```

    
2.应用初始化
    
```
 try{
      var result=await Configuration.instance.init('assets/files/config.yaml');
      print('init is $result');
    }catch(e){
      print('error is $e');
    }
    
正常输出:
I/flutter (23132): init is 初始化配置文件成功.
如有异常请自行排查.
```
3.获取指定环境下的值

```
 var host=Configuration.instance.getValueWidthEnvironment('HOST');
 print('host is $host');
 var wechat_appid=Configuration.instance.getValueWidthEnvironment('WEICHAT.APPID');
 print('wechat_appid is $wechat_appid');
 
 输出:
 I/flutter (23132): host is http://www.dev.com
 I/flutter (23132): wechat_appid is as232ewe

```
4.获取运行当前环境

```
var env=Configuration.instance.getEnvironment();
print('env is $env');

输出:
I/flutter (23132): env is ENVIRONMENT.DEV
```