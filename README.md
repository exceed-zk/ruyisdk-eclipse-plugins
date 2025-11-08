# custom-plugins

## 目录结构说明

```
├── features
├── plugins
│   ├── org.ruyisdk.core
│   ├── org.ruyisdk.devices
│   ├── org.ruyisdk.news
│   ├── org.ruyisdk.packages
│   ├── org.ruyisdk.intro
│   ├── org.ruyisdk.ruyi
│   └── org.ruyisdk.ui
└── README.md

```

## 插件说明

* **org.ruyisdk.core**: 基础类库，提供其它插件调用的公共功能
* **org.ruyisdk.devices**: RISC-V 设备管理和配置
* **org.ruyisdk.packages**: 包资源管理器，管理 SDK 包和依赖
* **org.ruyisdk.intro**: 定制化欢迎界面
* **org.ruyisdk.projectcreator**: 项目创建向导，支持多种 RISC-V 开发板
* **org.ruyisdk.ruyi**: Ruyi 包管理器集成，自动安装和更新工具链
* **org.ruyisdk.news**: 显示 RuyiSDK 新闻和更新
* **org.ruyisdk.ui**: 共享 UI 组件和样式

## 快速开始

### 在线安装（用户）

#### 方式一：使用 RuyiSDK IDE（推荐）

如果您使用的是 RuyiSDK IDE，更新站点已预配置：

1. 打开 RuyiSDK IDE
2. `Help` → `Install New Software...`
3. 从下拉列表中选择：`RuyiSDK Updates (GitHub) - https://ruyisdk.github.io/ruyisdk-eclipse-plugins/`
4. 选择 `RuyiSDK IDE` 并安装

#### 方式二：手动添加更新站点

在标准 Eclipse IDE 中：

1. 打开 Eclipse IDE
2. `Help` → `Install New Software...`
3. 点击 `Add...`，输入：
   - **Name**: `RuyiSDK Updates`
   - **Location**: `https://ruyisdk.github.io/ruyisdk-eclipse-plugins/`
4. 选择 `RuyiSDK IDE` 并安装

### 构建要求（开发者）

- Java 17 或更高版本（已测试 JDK 17、21、25）
- Apache Maven 3.9.0 或更高版本

### 构建插件

```bash
# 克隆仓库
git clone https://github.com/ruyisdk/ruyisdk-eclipse-plugins.git
cd ruyisdk-eclipse-plugins

# 构建所有插件
mvn clean verify

# 构建结果位于
# sites/repository/target/repository/
```

### 离线安装（使用 zip 包）

从 [Releases](https://github.com/ruyisdk/ruyisdk-eclipse-plugins/releases) 下载 `ruyisdk-eclipse-plugins.site.zip`，然后：

1. 解压 zip 文件到本地目录
2. 打开 Eclipse IDE
3. `Help` → `Install New Software...` → `Add...`
4. 输入：
   - **Name**: `RuyiSDK Plugins (Local)`
   - **Location**: `file:///path/to/extracted/zip/`
5. 选择 `RuyiSDK IDE` 并安装


## 版本兼容性

| RuyiSDK Plugins | Eclipse 版本 | Tycho 版本 | JDK 版本 | 支持架构 |
|----------------|-------------|-----------|---------|---------|
| 0.0.5          | 2024-12     | 4.0.10    | 17+     | x86_64, aarch64, riscv64 |
| 0.0.4          | 2024-12     | 4.0.10    | 21+     | x86_64, aarch64, riscv64 |
| 0.0.3          | 2024-09     | 4.0.8     | 21+     | x86_64, aarch64, riscv64 |

## 贡献

欢迎贡献！请参阅 [CONTRIBUTING.md](docs/developer/CONTRIBUTING.md) 了解详细信息。

### 编码规范

- 遵循 [Google Java Style Guide](docs/developer/coding-guidelines/style-guide.md)
- 使用提供的代码模板和格式化配置

## 文档
- [开发者文档](docs/developer/) - 开发和贡献指南
- [学习笔记](https://github.com/xijing21/eclipse-myplugins) - Eclipse 插件开发学习资料

## 相关仓库

- **打包工程**: https://github.com/ruyisdk/ruyisdk-eclipse-packages/
- **插件仓库**: https://github.com/ruyisdk/ruyisdk-eclipse-plugins/
- **学习笔记**: https://github.com/xijing21/eclipse-myplugins

## 许可证

Copyright (c) 2024 RuyiSDK and others.

本项目采用 Eclipse Public License v2.0 许可。
详见 [LICENSE](LICENSE) 文件。

## 支持

- 提交问题: https://github.com/ruyisdk/ruyisdk-eclipse-plugins/issues
- 讨论区: https://github.com/ruyisdk/ruyisdk-eclipse-plugins/discussions

