//Generated by the protocol buffer compiler. DO NOT EDIT!
// source: router/router_net_info.proto

package qaul.net.router_net_info;

@kotlin.jvm.JvmSynthetic
public inline fun userInfo(block: qaul.net.router_net_info.UserInfoKt.Dsl.() -> kotlin.Unit): qaul.net.router_net_info.RouterNetInfo.UserInfo =
  qaul.net.router_net_info.UserInfoKt.Dsl._create(qaul.net.router_net_info.RouterNetInfo.UserInfo.newBuilder()).apply { block() }._build()
public object UserInfoKt {
  @kotlin.OptIn(com.google.protobuf.kotlin.OnlyForUseByGeneratedProtoCode::class)
  @com.google.protobuf.kotlin.ProtoDslMarker
  public class Dsl private constructor(
    private val _builder: qaul.net.router_net_info.RouterNetInfo.UserInfo.Builder
  ) {
    public companion object {
      @kotlin.jvm.JvmSynthetic
      @kotlin.PublishedApi
      internal fun _create(builder: qaul.net.router_net_info.RouterNetInfo.UserInfo.Builder): Dsl = Dsl(builder)
    }

    @kotlin.jvm.JvmSynthetic
    @kotlin.PublishedApi
    internal fun _build(): qaul.net.router_net_info.RouterNetInfo.UserInfo = _builder.build()

    /**
     * <code>bytes id = 1;</code>
     */
    public var id: com.google.protobuf.ByteString
      @JvmName("getId")
      get() = _builder.getId()
      @JvmName("setId")
      set(value) {
        _builder.setId(value)
      }
    /**
     * <code>bytes id = 1;</code>
     */
    public fun clearId() {
      _builder.clearId()
    }

    /**
     * <code>bytes key = 2;</code>
     */
    public var key: com.google.protobuf.ByteString
      @JvmName("getKey")
      get() = _builder.getKey()
      @JvmName("setKey")
      set(value) {
        _builder.setKey(value)
      }
    /**
     * <code>bytes key = 2;</code>
     */
    public fun clearKey() {
      _builder.clearKey()
    }

    /**
     * <code>string name = 3;</code>
     */
    public var name: kotlin.String
      @JvmName("getName")
      get() = _builder.getName()
      @JvmName("setName")
      set(value) {
        _builder.setName(value)
      }
    /**
     * <code>string name = 3;</code>
     */
    public fun clearName() {
      _builder.clearName()
    }
  }
}
@kotlin.jvm.JvmSynthetic
public inline fun qaul.net.router_net_info.RouterNetInfo.UserInfo.copy(block: qaul.net.router_net_info.UserInfoKt.Dsl.() -> kotlin.Unit): qaul.net.router_net_info.RouterNetInfo.UserInfo =
  qaul.net.router_net_info.UserInfoKt.Dsl._create(this.toBuilder()).apply { block() }._build()