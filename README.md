<div align="center">
  <img width="555" alt="top_image.png" src="https://user-images.githubusercontent.com/81057658/167287398-e2927de2-8c62-4270-9505-f61ba335b69a.png">
  <h1 align="center">CircleManager</h1>
</div>
<br>

## サービス URL
### **https://www.circle-manager.com/**

<br>

## サービス概要
テニスやバドミントンなどのサークルで**出欠管理**と**ダブルスのランダムな組み合わせ作成**ができるアプリです。

<br>

## サービスを作ろうとした経緯
以前から所属しているバドミントンサークルで、シャッフルアプリでダブルスの組み合わせを決めていました。
<p>しかし、欲しい機能が完全に満たされているアプリは存在せず、アプリと名札を併用してシャッフルしていました。</p>
そこで、サークルメンバーの要望を全て反映させた新しいシャッフルアプリが欲しいと思い、作成に至りました。

<br>

  ## 主なページ内容

  |  ログイン前メニュー  |  マイページ |
  | ---- | ---- |
  |  <img width="1000" alt="menu" src="https://user-images.githubusercontent.com/81057658/167289153-2e100db4-c848-41c7-ae6b-abcaeb732897.png">  |  <img width="1000" alt="three_items" src="https://user-images.githubusercontent.com/81057658/167289137-6415ec6d-f03f-453d-bb66-9d826b108af5.png">  |
  |  ログインはLINEログインのみ対応しています。ログイン後はサークル作成やマイページなど複数のリンクが追加されます。 |  名前やアイコン画像等を編集することができます。また、所属しているサークルへはマイページから遷移できます。  |


  | サークル詳細ページ  |  イベント一覧ページ  |
  | ---- | ---- |
  | <img width="1280" alt="circle_show" src="https://user-images.githubusercontent.com/81057658/167298693-266249c8-63e2-43f8-bf42-36f83c0951a4.png"> | <img width="1280" alt="event_index" src="https://user-images.githubusercontent.com/81057658/167298724-725ec12c-902e-4102-b835-32219b73c33b.png"> |
  | サークルの紹介文、トップ画像、その他イベント時の画像等を掲載することができます。 | イベント一覧ページでは出欠状態を色付けして、すぐに状態を判別することができます。 |


  | イベント詳細ページ  |  シャッフルページ  |
  | ---- | ---- |
  | <img width="1280" alt="event_show" src="https://user-images.githubusercontent.com/81057658/167298849-dd5444ae-8525-43a5-a416-32a698e70b13.png"> | <img width="1280" alt="shuffle" src="https://user-images.githubusercontent.com/81057658/167298866-7ab7d2c1-86ed-4095-adb4-a789eb7d0041.gif"> |
  | イベントの詳細情報、サークルメンバーの出欠状態確認できます。また、シャッフルページへはこちらのページからのみ遷移できます。 | イベントに出席と回答したメンバーだけで試合をランダムに組むことができます。赤色の部分はメンバー毎の試合回数を表示しています。また、タップでメンバーを入れ替えて調整することもできます。 |


  <br>

  ***

  <br>

  ## ER図
  <img width="555" alt="hoshime_erd" src="https://user-images.githubusercontent.com/76583053/147761791-8d12b707-d2fa-4e65-9463-87e5c5bbc570.png">

  <br>

  ### 使用技術

  #### バックエンド
  - Ruby 2.7.5
  - Rails 6.1.4

  #### フロントエンド
  - HTML
  - CSS(SCSS)
  - Tailwind CSS
  - JavaScript

## ER図
<img width="1000" alt="erdrow" src="https://user-images.githubusercontent.com/81057658/167300438-0bfb4921-85d3-4018-9f46-4672bf9e3d9c.png">
