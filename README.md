# homebrew-loong64

面向 **loongarch64** 的 Homebrew tap 示例仓库。

> 上游 Homebrew 尚不支持 loongarch64（仅 macOS 与 x86_64/aarch64 Linux）。
> 本 tap 面向自维护的 loong64 移植版本，或作为二进制分发索引使用。

## 结构

```
Formula/           # formula 定义
```

bottle 与索引由 `~/infra/scripts/brew-add-bottle.sh` 生成并发布到站点
`http://<host>/brew/`（本地演练为 `http://127.0.0.1:8080/brew/`）。

## 使用

```bash
brew tap <org>/loong64
brew install hello
```

## 新增 formula

1. 在 `Formula/` 下新增 `<name>.rb`；
2. 用 `scripts/brew-add-bottle.sh <name> <version> <tarball> "<desc>"` 发布对应 bottle；
3. 脚本会把 bottle 的 sha256 回填到 formula。
