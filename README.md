# Jigger.work

## サイト概要
カクテルやモクテル（ノンアルコールカクテル）のレシピ投稿・検索サイトです。
その時の気分によって、レシピを検索したりオリジナルのレシピを投稿することができます。
全ユーザーのお気に入りデータを解析し、レシピ同士の類似度を算出することでユーザーに類似レシピを提案します。

<img width="1440" alt="jigger cocktails" src="https://user-images.githubusercontent.com/59522269/94928915-525e1080-04ff-11eb-9ac1-6957adfe6be7.png">
<img width="1440" alt="jigger cocktail show" src="https://user-images.githubusercontent.com/59522269/94930556-8fc39d80-0501-11eb-908a-06c52ddadb21.png">

### サイトテーマ
自粛が勧められるコロナ禍の中、以前のようにバーへ足を運べなくなったお酒好きの方へ。
無限とも思えるカクテルレシピの中で、自分の好みの味のレシピを探しやすいサイトです。

### テーマを選んだ理由
リモート呑みが広がりつつある昨今、コンビニのお酒ももちろん良いですが、おつまみを作るのと一緒に
自作のカクテルを作れば話のネタにもなり、より家呑みを楽しめると考えこのサイトを作ろうと思い立ちました。

### ターゲットユーザ
お酒好きの大人はもちろんの事、モクテルの種類も充実させることでお酒が苦手な方から未成年まで幅広いユーザー層を
想定しています。

### 主な利用シーン
家呑みのお供に。また、好きなレシピを登録しておくことで、バーでカクテルを注文する際に参考にするといった使い方も
可能です。

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
![image](https://user-images.githubusercontent.com/59522269/95648039-3ebe3580-0b0f-11eb-8780-243fc7079e91.png)

