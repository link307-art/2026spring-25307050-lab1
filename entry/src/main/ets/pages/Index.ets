import { webview } from '@kit.ArkWeb';
import { abilityAccessCtrl, common, PermissionRequestResult } from '@kit.AbilityKit';

@Entry
@Component
struct ParticleVisualizer {
  // 初始化鸿蒙内置的高性能 Web 视图控制器
  webController: webview.WebviewController = new webview.WebviewController();

  // 运行状态跟踪
  @State hasCameraPermission: boolean = false;

  aboutToAppear() {
    this.requestCameraPermission();
  }

  // 动态申请鸿蒙系统的摄像头权限（MediaPipe 所需）
  private requestCameraPermission() {
    const context = getContext(this) as common.UIAbilityContext;
    const atManager = abilityAccessCtrl.createAtManager();

    atManager.requestPermissionsFromUser(context, ['ohos.permission.CAMERA'])
      .then((data: PermissionRequestResult) => {
        if (data.authResults[0] === 0) {
          this.hasCameraPermission = true;
          // 权限获取成功，刷新或加载内核
          this.webController.refresh();
        } else {
          console.error('ParticleVisualizer: 摄像头权限被拒绝，无法进行手势追踪');
        }
      })
      .catch((err: Error) => {
        console.error(`ParticleVisualizer: 权限申请异常: ${err.message}`);
      });
  }

  build() {
    Stack() {
      // 全屏深空底色，防止 Web 加载瞬间闪白
      Rect()
        .width('100%')
        .height('100%')
        .fill('#020208')

      // 核心渲染引擎载体
      Web({
        src: $rawfile('index.html'),
        controller: this.webController
      })
        .width('100%')
        .height('100%')
        .backgroundColor(Color.Transparent) // 允许半透明层叠
        .domStorageAccess(true)              // 开启 DOM 存储
        .imageAccess(true)                   // 允许加载外部图片资源
        .onlineImageAccess(true)
        .javaScriptAccess(true)              // 开启 JavaScript 引擎
        .mediaPlayGestureAccess(false)       // 允许无需用户手势自动播放 Video
        .onPermissionRequest((event) => {    // 核心：拦截 H5 内部的摄像头授权申请，并自动放行
          if (event) {
            let resources = event.request.getAccessibleResource();
            if (resources && resources.length > 0) {
              // 匹配是否是摄像头请求
              event.request.grant(resources);
            }
          }
        })
        .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM]) // 沉浸式全面屏适配
    }
    .width('100%')
    .height('100%')
  }
}