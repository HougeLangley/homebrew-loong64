# 贡献指南

感谢您对 Homebrew Loong64 Tap 的兴趣！本文档将帮助您了解如何为项目做出贡献。

## 目录

- [开发环境](#开发环境)
- [Formula 编写规范](#formula-编写规范)
- [测试](#测试)
- [提交 PR](#提交-pr)

## 开发环境

### 系统要求

- LoongArch 64 架构机器（或龙芯开发板）
- AOSC OS 或兼容的 Linux 发行版
- Homebrew 5.0+

### 设置开发环境

```bash
# 1. Clone 仓库
git clone https://github.com/loongarch/homebrew-loong64.git
cd homebrew-loong64

# 2. 创建本地 Tap 链接
ln -s $(pwd) $(brew --repo)/Library/Taps/loongarch/homebrew-loong64

# 3. 验证安装
brew tap loongarch/homebrew-loong64
```

## Formula 编写规范

### 基础结构

每个 Formula 必须包含以下要素：

```ruby
class PackageName < Formula
  desc "简短描述"
  homepage "https://example.com"
  url "https://example.com/download/package-1.0.tar.gz"
  sha256 "校验和"
  license "MIT"

  # 依赖声明
  depends_on "dependency"

  def install
    # LoongArch 架构检测
    cpu = Hardware::CPU.loongarch? ? "loongarch64" : Hardware.oldest_cpu
    
    system "./configure", "--prefix=#{prefix}",
                          "--build=#{cpu}-unknown-linux-gnu"
    system "make", "install"
  end

  test do
    system "#{bin}/package", "--version"
  end
end
```

### 架构修复模板

所有 Formula 必须包含 LoongArch 架构支持：

```ruby
cpu = Hardware::CPU.loongarch? ? "loongarch64" : Hardware.oldest_cpu
args << "--build=#{cpu}-unknown-linux-gnu"
```

### 常见修复模式

#### 1. 使用系统库

对于编译困难的包：

```ruby
def install
  # 优先使用系统库
  if File.exist?("/usr/lib/libexample.so")
    system "cp", "/usr/lib/libexample*", "#{lib}/"
    system "cp", "/usr/include/example.h", "#{include}/"
  else
    # 从源码构建
    system "./configure", *std_configure_args
    system "make", "install"
  end
end
```

#### 2. 禁用有问题的依赖

```ruby
args = [
  "--prefix=#{prefix}",
  "--disable-brotli",  # 禁用 brotli
  "--without-pcre2",   # 移除 pcre2
]
```

#### 3. 自定义编译器标志

```ruby
ENV["CFLAGS"] = "-O2 -fpermissive"
ENV["CC"] = "gcc-15"
```

## 构建流程

本项目使用**容器化构建系统**，不是直接在宿主机上构建。

### 容器化构建流程

```
1. 复制基础镜像 → homebrew-build-<package>
2. 启动 systemd-nspawn 容器
3. 使用 oma 安装依赖 (不是 apt)
4. cargo/make 编译
5. 生成 bottle 并上传 VPS
6. 销毁容器
```

### 执行构建

构建在专用编译机 (192.168.50.244) 上执行：

```bash
# 单个包构建
./scripts/batch_build.sh <package-name>

# 批量构建
./scripts/batch_build.sh -a

# 或使用 Makefile
make build
```

### 三个环境区分

| 环境 | 路径/IP | 职责 |
|------|---------|------|
| **GitHub 仓库** | `~/Test/Homebrew-LoongArch/` | Formula、文档、脚本 |
| **构建编译机** | `192.168.50.244` | 容器化构建、生成 bottles |
| **VPS 分发** | `47.242.26.188` | 存储和分发 bottles |

## 测试

### 本地测试 (GitHub 仓库)

```bash
# 检查 Formula 语法
brew audit --strict Formula/my-formula.rb

# 注意: 不要在本地直接安装测试
# 构建应在编译机上使用容器化流程执行
```

### 在编译机上测试

```bash
# SSH 到编译机
ssh houge@192.168.50.244

# 使用容器化流程测试
./scripts/batch_build.sh my-formula
```

### 测试检查清单

- [ ] Formula 语法正确
- [ ] 能在 loongarch64 上成功构建
- [ ] `brew test` 通过
- [ ] `brew audit --strict` 无警告
- [ ] 没有引入新的 brotli/berkeley-db@5 依赖

## 提交 PR

### PR 流程

1. **创建分支**
   ```bash
   git checkout -b add-formula-<package-name>
   ```

2. **提交更改**
   ```bash
   git add Formula/<package-name>.rb
   git commit -m "Add formula for <package-name>"
   git push origin add-formula-<package-name>
   ```

3. **创建 PR**
   - 标题格式: `Add <package-name> <version>`
   - 描述中包含:
     - 包的功能简介
     - 构建测试结果
     - 依赖关系说明

### PR 检查清单

- [ ] 已阅读并遵循本指南
- [ ] Formula 包含架构修复
- [ ] 已本地测试通过
- [ ] 提交信息清晰明确
- [ ] 只有一个 Formula 变更

## 代码审查

维护者会检查以下要点：

1. **架构支持** - 是否包含 `--build=loongarch64-unknown-linux-gnu`
2. **依赖管理** - 是否避免了已知问题依赖
3. **代码风格** - 是否符合 Ruby/Homebrew 规范
4. **测试覆盖** - 是否有基本的 test 块

## 常见问题

### Q: 我的包依赖 brotli 怎么办？

A: 尝试：
1. 检查是否可以用系统 brotli
2. 禁用 brotli 支持（大多数包是可选的）
3. 在 PR 中说明无法构建的原因

### Q: 如何处理 autotools 架构识别错误？

A: 添加 `--build` 参数：
```ruby
system "./configure", "--build=#{cpu}-unknown-linux-gnu", *std_configure_args
```

### Q: 可以使用 Python/Rust/Go 编写工具吗？

A: 可以，但需要确保：
- 使用 Homebrew 提供的运行时（如 `depends_on "python@3.13"`）
- 或者声明 `uses_from_macos "python"`

## 获取帮助

- 查看 [docs/](docs/) 目录下的详细文档
- 在 Issue 中提问
- 参考已有的 Formula 作为示例

## 许可证

通过提交 PR，您同意您的贡献将按照 [MIT License](../LICENSE) 进行许可。
