# Obsidian Mobile Test

BRAT (Beta Reviewers Auto-update Tool) 経由でプラグインをインストールするためのダミーリポジトリです。

## 概要

このリポジトリは、開発中のObsidianプラグインをBRAT経由でモバイル端末にインストール・テストするために使用します。

指定したプラグインのソースディレクトリでビルドを実行し、生成された `main.js` と `styles.css` をこのリポジトリにコピーしてリリースを作成します。

> **Note:** `manifest.json` はこのリポジトリ固有の情報（プラグインID、名前など）を保持するためコピーしません。元のプラグインと同じ `manifest.json` を使用すると競合が発生します。

## はじめに

このリポジトリをクローンしてください:

```bash
git clone https://github.com/takeshy/obsidian-mobile-test.git
cd obsidian-mobile-test
```

## 必要条件

- Node.js
- Git
- ソースプラグインが `npm run build` でビルド可能であること

## 使い方

### 1. ソースプラグインから同期

```bash
./sync-from.sh /path/to/source/plugin
```

このスクリプトは以下を実行します:

1. 指定ディレクトリで `npm run build` を実行
2. 生成された `main.js` と `styles.css` をこのリポジトリにコピー
3. ソースディレクトリ名をコミットメッセージとしてコミット
4. `npm version patch` でバージョンをバンプ
5. GitHub にプッシュ

### 2. 自動リリース

プッシュ後、GitHub Actions が自動的にリリースを作成します。

### 3. BRAT でインストール

> ⚠️ **重要:** BRATでインストールする前に、Obsidianの「コミュニティプラグイン」設定で**オリジナルのプラグインを無効にしてください**。両方のプラグインが有効になっていると競合が発生します。

1. Obsidian 設定 → コミュニティプラグイン で**オリジナルのプラグインを無効化**
2. Obsidian で BRAT プラグインをインストール
3. BRAT 設定で「Add Beta plugin」を選択
4. リポジトリの URL を入力:
   ```
   https://github.com/xxxx/obsidian-mobile-test
   ```
5. プラグインがインストールされます

> `xxxx` は自分のGitHubユーザー名に置き換えてください。

### 4. オリジナルに戻す

テスト終了後、オリジナルのプラグインに戻すには:

1. Obsidian 設定 → コミュニティプラグイン で**このテストプラグインを無効化**
2. **オリジナルのプラグインを有効化**

## ファイル構成

```
.
├── main.js           # ビルド済みプラグインコード
├── styles.css        # スタイルシート
├── manifest.json     # プラグインマニフェスト（このリポジトリ固有）
├── versions.json     # バージョン履歴
├── sync-from.sh      # 同期スクリプト
├── package.json      # バージョン管理用
├── version-bump.mjs  # バージョン更新スクリプト
└── LICENSE
```

## ワークフロー

```
ソースプラグイン                    このリポジトリ
     │                                   │
     │  ./sync-from.sh /path/to/src      │
     │ ─────────────────────────────────>│
     │                                   │
     │  1. npm run build                 │
     │  2. copy main.js, styles.css      │
     │  3. git commit & version bump     │
     │  4. git push                      │
     │                                   │
     │              GitHub Actions       │
     │                    │              │
     │                    v              │
     │              Create Release       │
     │                    │              │
     │                    v              │
     │              BRAT でインストール可能
```

## 注意事項

- このリポジトリはテスト・開発用です
- 本番環境では元のプラグインリポジトリを使用してください
- `manifest.json` の `id` と `name` は元のプラグインと異なります

## ライセンス

MIT License
