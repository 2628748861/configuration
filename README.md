# yaml_config_reader 

A new Flutter package project for yaml config reader.

## Getting Started

这是一个用于获取yaml配置文件的工具.类似Android buildConfig拥有环境变量,因此我们只需要定义好不同环境的key-value值,即可在应用中实现读取当前环境的值.
## 注意

环境编译依然使用flutter自带编译模式.

- debug模式(对应插件环境为:ENVIRONMENT.DEV)
```
flutter run --debug
```
- profile模式(对应插件环境为:ENVIRONMENT.TEST)
```
flutter run --profile
```
- release模式(对应插件环境为:ENVIRONMENT.PRODUCT)
```
flutter run --release
```

[github项目主页地址](https://github.com/2628748861/configuration)

## 安装依赖

```
dependencies:
  yaml_config_reader: xx
  yaml: ^3.x.x
```

## 使用方法

###### 在已安装依赖的前提下,按如下操作完成:
-  ###### 创建yaml配置文件
```
文件位置: assets/files/config.yaml

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
-  ###### 插件初始化
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
-  ###### 读取yaml配置文件

    - ##### 获取当前运行环境
    ```
    var env=Configuration.instance.getEnvironment();
    print('env is $env');
    
    输出:
    I/flutter (23132): env is ENVIRONMENT.DEV
    ```
    - ##### 获取指定环境下key的值
    ```
     var host=Configuration.instance.getValueWidthEnvironment('HOST');
     print('host is $host');
     var wechat_appid=Configuration.instance.getValueWidthEnvironment('WEICHAT.APPID');
     print('wechat_appid is $wechat_appid');
     
     输出:
     I/flutter (23132): host is http://www.dev.com
     I/flutter (23132): wechat_appid is as232ewe
    
    ```
    




