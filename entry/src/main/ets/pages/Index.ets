// 完整代码（可直接复制使用）
@Entry
@Component
struct ColorTextChanger {
  // 状态变量：控制文字内容
  @State message: string = 'Hello World'
  // 状态变量：控制文字颜色
  @State textColor: Color = Color.Black

  build() {
    Column() {
      // 动态文本组件
      Text(this.message)
        .fontSize(30)
        .fontColor(this.textColor)
        .margin(20)

      // 控制按钮
      Button('点击变换')
        .width(150)
        .height(50)
        .backgroundColor('#409EFF')
        .fontColor(Color.White)
        .onClick(() => {
          // 随机切换文字内容
          this.message = this.getRandomMessage()
          // 随机切换文字颜色
          this.textColor = this.getRandomColor()
        })
        .margin(10)
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
  }

  // 随机消息生成
  private getRandomMessage(): string {
    const messages = [
      'HarmonyOS',
      'ArkTS',
      '你好鸿蒙',
      '动态效果',
      '点击变色'
    ]
    return messages[Math.floor(Math.random() * messages.length)]
  }

  // 随机颜色生成
  private getRandomColor(): Color {
    const colors = [
      Color.Red,
      Color.Blue,
      Color.Green,
      Color.Orange,
    ]
    return colors[Math.floor(Math.random() * colors.length)]
  }
}