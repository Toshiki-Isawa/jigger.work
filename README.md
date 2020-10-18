# Jigger.work

## サイト概要
カクテルやモクテル（ノンアルコールカクテル）のレシピ投稿・検索サイトです。
登録ユーザーのお気に入りデータを解析し、レシピ同士の類似度を算出しているのでより正確な類似レシピを表示できます。
また、スマートフォンでも閲覧が出来るようにレスポンシブ対応もしています。

<img width="1440" alt="top-page" src="https://user-images.githubusercontent.com/59522269/96080945-3c831f00-0ef3-11eb-8a15-36c241e58c1a.png">
<img width="1439" alt="index-page" src="https://user-images.githubusercontent.com/59522269/96213881-f7272600-0fb4-11eb-8681-da4adad20788.png">
<img width="1440" alt="show-page" src="https://user-images.githubusercontent.com/59522269/96213898-00b08e00-0fb5-11eb-81ef-b7319dd6aade.png">

### サイトテーマ
自粛が勧められるコロナ禍の中、以前のようにバーへ足を運べなくなったお酒好きの方へ。
無限とも思えるカクテルレシピの中で、自分の好みの味のレシピを探しやすいサイトです。

### テーマを選んだ理由
リモート呑みが広がりつつある昨今、コンビニのお酒ももちろん良いですが、おつまみを作るのと一緒に自作のカクテルを作れば話のネタにもなり、より家呑みを楽しめると考えこのサイトを作ろうと思い立ちました。

### ターゲットユーザ
お酒好きの大人はもちろんの事、モクテルの種類も充実させることでお酒が苦手な方から未成年まで幅広いユーザー層を想定しています。

### 主な利用シーン
家呑みのお供に。また、好きなレシピを登録しておくことで、バーでカクテルを注文する際に参考にするといった使い方も可能です。

## 設計書
- ER図：https://drive.google.com/file/d/16QyIc_TiDdQNt7bMZqKwdRM37k2JfiDV/view?usp=sharing
- データベース設計：https://docs.google.com/spreadsheets/d/1HKdf40T_zGml8pDR_0ivoPfJKiNJkzMO9nCNTQ-TtDY/edit?usp=sharing
- 詳細設計：https://docs.google.com/spreadsheets/d/1ml3zO8AkYwl9wHE_pER7QCZoKMnzmxGwneqXcX806n8/edit?usp=sharing
- 画面遷移図：https://drive.google.com/file/d/1DsNItj1giHDZxoHLb4D6PRURu3L43FIH/view?usp=sharing
- ワイヤーフレーム：https://drive.google.com/file/d/1LjqIAnjtYU719c0cnWLLIBL-gkA1dJWt/view?usp=sharing

### 機能一覧
<https://docs.google.com/spreadsheets/d/e/2PACX-1vRFK1YLlc_EjQoa_v-gJ_8-2Yx5_XWGg18kcis7NXoMTGeg7wpNb7SUz76EkqR_GYvpOF_24jtnB5Cv/pubhtml>

## 開発環境
- OS：Linux(CentOS)
- 言語：HTML,CSS,JavaScript,Ruby,SQL
- フレームワーク：Ruby on Rails
- JSライブラリ：jQuery
- 仮想環境：Vagrant,VirtualBox

## AWSインフラ構成
- 設計書https://docs.google.com/spreadsheets/d/1Klonn1-FawrEMv52VC36DldZsRRnweObUtXfFd-0fgY/edit?usp=sharing

![AWSインフラ構成図](https://user-images.githubusercontent.com/59522269/95741991-4413af80-0cca-11eb-8d61-42cda9af9401.jpg)
