library configuration;

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:yaml/yaml.dart';

enum ENVIRONMENT { DEV, TEST, PRODUCT }

class Configuration {
  ENVIRONMENT _environment;
  var _yamlData;
  Configuration._privateConstructor();
  static final Configuration instance = Configuration._privateConstructor();

  /// 初始化配置文件
  ///*/
  Future<String> init(String yamlPath) async {
    try {
      ENVIRONMENT environment= kDebugMode?ENVIRONMENT.DEV:kProfileMode?ENVIRONMENT.TEST:ENVIRONMENT.PRODUCT;
      this._environment = environment;
      final data = await rootBundle.loadString(yamlPath);
      _yamlData = loadYaml(data);
      return '初始化配置文件成功.';
    } catch (e) {
      throw '初始化配置文件失败!=>$e';
    }
  }

  /// 查询指定节点串下的值
  ///
  /// 举例说明:
  /// HOST:
  ///    DEV: 'http://www.xx.com'
  ///
  /// getValueWidthNode(['HOST',['DEV']])
  ///
  /// */
  dynamic getValueWidthNode(List<String> keys) {
    if (keys == null || keys.isEmpty) throw '查询的节点不能为空';
    dynamic value;
    int index = 0;
    keys.forEach((element) {
      if (index == 0) {
        index++;
        value = _getValueWidthMap(_yamlData, element);
      } else {
        value = _getValueWidthMap(value, element);
      }
    });
    return value;
  }

  /// 查询指定节点key的值(已做了环境区分)
  ///
  /// 举例说明:
  /// HOST:
  ///   DEV: 'http://www.dev.com'
  ///   TEST: 'http://www.test.com'
  ///   PRODUCT: 'http://www.product.com'
  ///
  /// getValueWidthEnvironment(['HOST'])
  ///
  /// */
  dynamic getValueWidthEnvironment(String key) {
    if (key.isEmpty) throw '查询的节点不能为空';
    String environmentStr;
    switch (_environment) {
      case ENVIRONMENT.DEV:
        environmentStr = 'DEV';
        break;
      case ENVIRONMENT.TEST:
        environmentStr = 'TEST';
        break;
      case ENVIRONMENT.PRODUCT:
        environmentStr = 'PRODUCT';
        break;
    }
    int index=0;
    dynamic value;
    key.split('.').forEach((element) {
      if(index==0){
        value=_getValueWidthMap(_yamlData,environmentStr)[element];
      }else{
        value=value[element];
      }
      index++;
    });

    return value;
  }

  /// 查询指定根节点key的值
  ///
  /// 举例说明:
  /// HOST:
  ///   DEV: 'http://www.dev.com'
  ///   TEST: 'http://www.test.com'
  ///   PRODUCT: 'http://www.product.com'
  ///
  /// getValue(['HOST'])
  ///
  /// */
  dynamic getValue(String key) {
    return _getValueWidthMap(_yamlData, key);
  }

  /// 查询指定yaml的key的值
  ///
  /// 举例说明:
  /// DEV: 'http://www.xx.com'
  ///
  /// getValue(['HOST'])
  ///
  /// */
  dynamic _getValueWidthMap(YamlMap map, String key) {
    return map[key];
  }

  /// 获取当前环境
  dynamic getEnvironment()=>_environment;
}

