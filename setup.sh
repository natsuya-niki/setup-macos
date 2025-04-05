#!/bin/bash

# ================================================================================
# 【For Mac】setup-macos.sh : Setup MacOS
# Version: 1.0.0
# Last Updated: 2024-03-21
# Supported macOS: 15.x (Sonoma)
# ================================================================================

if [ "$(uname)" != "Darwin" ] ; then
  echo 'Not macOS!'
  exit 1
fi

# macOSバージョンチェック
os_version=$(sw_vers -productVersion)
if [[ ! "$os_version" =~ ^15\..* ]]; then
  echo "This script is designed for macOS 15.x (Sonoma)."
  echo "Your macOS version: $os_version"
  exit 1
fi

echo 'Setup MacOS'

## アニメーション
defaults write -g NSAutomaticWindowAnimationsEnabled -bool false    # ファイルを開くときのアニメーションを無効にする
defaults write -g NSInitialToolTipDelay -integer 0    # ツールチップ表示までのタイムラグをなくす
defaults write -g NSWindowResizeTime 0.1    # ダイアログ表示やウィンドウリサイズ速度を高速化する
defaults write -g com.apple.springing.delay -float 0    # スプリングロード遅延を除去する
defaults write -g com.apple.springing.enabled -bool true    # ディレクトリのスプリングロードを有効にする
defaults write -g AppleShowScrollBars -string "Always"    # スクロールバーを常時表示する
defaults write -g NSWindowResizeTime -float 0.001    # コンソールアプリケーションの画面サイズ変更を高速にする

## キーリピート
defaults write -g KeyRepeat -int 2    # キーリピートの速度（macOS 15系でも有効、値は1-15の範囲）
defaults write -g InitialKeyRepeat -int 15    # キーリピート開始までのタイミング（macOS 15系でも有効、値は1-15の範囲）

## Dock
defaults write com.apple.dock autohide-delay -float 0    # Dock が表示されるまでの待ち時間を無効にする
defaults write com.apple.dock autohide -bool true    # Dockを自動で隠す

## Finder
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"    # Finderのデフォルト表示をリスト表示に設定
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true    # Finder のタイトルバーにフルパスを表示する
defaults write com.apple.finder _FXSortFoldersFirst -bool true    # 名前で並べ替えを選択時にディレクトリを前に置くようにする
defaults write com.apple.finder AnimateWindowZoom -bool false    # フォルダを開くときのアニメーションを無効にする
defaults write com.apple.finder AppleShowAllFiles YES    # 不可視ファイルを表示する
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"    # 検索時にデフォルトでカレントディレクトリを検索する
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false    # 拡張子変更時の警告を無効化する
defaults write com.apple.finder QLEnableTextSelection -bool true    # クイックルックでテキストを選択可能にする
defaults write com.apple.Finder QuitMenuItem -bool true    # Finder を終了させる項目を追加する
defaults write com.apple.finder ShowPathbar -bool true    # パスバーを表示する
defaults write com.apple.finder ShowStatusBar -bool true    # ステータスバーを表示する
defaults write com.apple.finder ShowTabView -bool true    # タブバーを表示する
defaults write com.apple.Safari ShowFullURLInSmartSearchField -bool true    # アドレスバーに完全な URL を表示する
defaults write com.apple.Safari ShowStatusBar -bool true    # ステータスバーを表示する

## Safari
defaults write com.apple.Safari IncludeDevelopMenu -bool true    # Safari の開発・デバッグメニューを有効にする
defaults write com.apple.Safari IncludeInternalDebugMenu -bool true    # Safari の開発・デバッグメニューを有効にする
defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true    # Safari の開発・デバッグメニューを有効にする
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled -bool true    # Safari の開発・デバッグメニューを有効にする
defaults write -g WebKitDeveloperExtras -bool true    # Safari のコンテキストメニューに Web インスペクタを追加する

## スクリーンショット
defaults write com.apple.screencapture disable-shadow -bool true    # スクリーンショットの影をなくす
defaults write com.apple.screencapture type -string "png"    # スクリーンショットの保存形式を PNG にする
defaults write com.apple.screencapture location ~/Pictures/    # スクリーンショットの保存先を変更
defaults write com.apple.screencapture name "SS"    # スクリーンショットのファイル名のプレフィックス「SS」を設定
# defaults write com.apple.screencapture "include-date" -bool false    # スクリーンショットのファイル名から日付を削除（SS.png, SS 1.png, ...）

## .DS_Store
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true    # USB やネットワークストレージに .DS_Store ファイルを作成しない
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true    # USB やネットワークストレージに .DS_Store ファイルを作成しない

## 時刻表示
defaults write com.apple.menuextra.clock DateFormat -string "M\u6708d\u65e5(EEE)  H:mm"    # 日付と時刻のフォーマット（24時間表示、「1月1日(月)」）
defaults write com.apple.menuextra.clock FlashDateSeparators -int 1    # 「:」の点滅をする

## その他 システム設定
chflags nohidden ~/Library    # ~/Library ディレクトリを見えるようにする
sudo chflags nohidden /Volumes    # /Volumes ディレクトリを見えるようにする
sudo nvram SystemAudioVolume=" "    # ブート時のサウンドを無効化する
defaults write com.apple.terminal StringEncodings -array 4    # UTF-8 のみを使用する
defaults write com.apple.CrashReporter DialogType -string "none"    # クラッシュレポートを無効化する
defaults write com.apple.LaunchServices LSQuarantine -bool false    # 未確認のアプリケーションを実行する際のダイアログを無効にする
defaults write com.apple.NetworkBrowser ShowThisComputer -bool true    # ファイル共有を有効にした時、共有先に自分の Mac を表示させる
defaults write com.apple.Safari AutoOpenSafeDownloads -bool false    # ファイルのダウンロード後に自動でファイルを開くのを無効化する
defaults write -g AppleShowAllExtensions -bool true    # 全ての拡張子のファイルを表示する

## その他便利設定
# ユーザー配下のディレクトリを英語表記にする
rm ~/Applications/.localized
rm ~/Desktop/.localized
rm ~/Documents/.localized
rm ~/Downloads/.localized
rm ~/Library/.localized
rm ~/Movies/.localized
rm ~/Music/.localized
rm ~/Public/.localized
rm ~/Pictures/.localized

## macOS 15系（Sonoma）対応設定
# Stage Managerの設定
defaults write com.apple.WindowManager StageManagerEnabled -bool false    # Stage Managerを無効化する（macOS 15系で追加）
defaults write com.apple.WindowManager StageManagerHideOnDesktop -bool true    # デスクトップでStage Managerを非表示にする（macOS 15系で追加）

# ウィジェットの設定
defaults write com.apple.WidgetKit WidgetsEnabled -bool true    # ウィジェットを有効にする（macOS 15系で追加）

# システム設定のプライバシー設定
defaults write com.apple.TCC AllowSystemServices -bool true    # システムサービスのアクセスを許可する（macOS 15系で追加）

# バッテリー最適化
defaults write com.apple.energy-saver "Battery Power" -dict-add "Automatic Graphics Switching" -bool true    # 自動グラフィックス切り替えを有効にする（macOS 15系で追加）
defaults write com.apple.energy-saver "Battery Power" -dict-add "Low Power Mode" -bool true    # 低電力モードを有効にする（macOS 15系で追加）

## 反映（ログイン中）
killall Finder
killall Dock
killall SystemUIServer

echo 'Finished.'
echo 'Restart to reflect all settings.'


# --------------------------------------------------------------------------------
