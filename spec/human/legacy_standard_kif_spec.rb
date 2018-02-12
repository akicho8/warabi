# 昔作ったテストでコンパクトにしたぶん何をテストしているのか判然としなくなっているもの

require_relative "../spec_helper"

module Warabi
  describe "将棋連盟が定めている人間向け棋譜入力" do
    before do
      @params = {pieces_add: "飛 角 銀"}
    end

    describe "http://www.shogi.or.jp/faq/kihuhyouki.html" do
      describe "龍" do
        it "パターンA" do
          @params.update(init: ["９一龍", "８四龍"])
          Mediator.read_spec(@params.merge(exec: "８二龍引")).should == ["８二龍(91)", "８二龍引"]
          Mediator.read_spec(@params.merge(exec: "８二龍上")).should == ["８二龍(84)", "８二龍上"]
        end
        it "パターンB" do
          @params.update(init: ["５二龍", "２三龍"])
          Mediator.read_spec(@params.merge(exec: "４三龍寄")).should == ["４三龍(23)", "４三龍寄"]
          Mediator.read_spec(@params.merge(exec: "４三龍引")).should == ["４三龍(52)", "４三龍引"]
        end
        it "パターンC" do
          @params.update(init: ["５五龍", "１五龍"])
          Mediator.read_spec(@params.merge(exec: "３五龍左")).should == ["３五龍(55)", "３五龍左"]
          Mediator.read_spec(@params.merge(exec: "３五龍右")).should == ["３五龍(15)", "３五龍右"]
        end
        it "パターンD" do
          @params.update(init: ["９九龍", "８九龍"])
          Mediator.read_spec(@params.merge(exec: "８八龍左")).should == ["８八龍(99)", "８八龍左"]
          Mediator.read_spec(@params.merge(exec: "８八龍右")).should == ["８八龍(89)", "８八龍右"]
        end
        it "パターンE" do
          @params.update(init: ["２八龍", "１九龍"])
          Mediator.read_spec(@params.merge(exec: "１七龍左")).should == ["１七龍(28)", "１七龍左"]
          Mediator.read_spec(@params.merge(exec: "１七龍右")).should == ["１七龍(19)", "１七龍右"]
        end
      end

      describe "馬" do
        it "パターンA" do
          @params.update(init: ["９一馬", "８一馬"])
          Mediator.read_spec(@params.merge(exec: "８二馬左")).should == ["８二馬(91)", "８二馬左"]
          Mediator.read_spec(@params.merge(exec: "８二馬右")).should == ["８二馬(81)", "８二馬右"]
        end
        it "パターンB" do
          @params.update(init: ["９五馬", "６三馬"])
          Mediator.read_spec(@params.merge(exec: "８五馬寄")).should == ["８五馬(95)", "８五馬寄"]
          Mediator.read_spec(@params.merge(exec: "８五馬引")).should == ["８五馬(63)", "８五馬引"]
        end
        it "パターンC" do
          @params.update(init: ["１一馬", "３四馬"])
          Mediator.read_spec(@params.merge(exec: "１二馬引")).should == ["１二馬(11)", "１二馬引"]
          Mediator.read_spec(@params.merge(exec: "１二馬上")).should == ["１二馬(34)", "１二馬上"]
        end
        it "パターンD" do
          @params.update(init: ["９九馬", "５九馬"])
          Mediator.read_spec(@params.merge(exec: "７七馬左")).should == ["７七馬(99)", "７七馬左"]
          Mediator.read_spec(@params.merge(exec: "７七馬右")).should == ["７七馬(59)", "７七馬右"]
        end
        it "パターンE" do
          @params.update(init: ["４七馬", "１八馬"])
          Mediator.read_spec(@params.merge(exec: "２九馬左")).should == ["２九馬(47)", "２九馬左"]
          Mediator.read_spec(@params.merge(exec: "２九馬右")).should == ["２九馬(18)", "２九馬右"]
        end
      end
    end

    it "真右だけ" do
      @params.update({init: [
            "______", "______", "______",
            "______", "______", "４五と",
            "______", "______", "______",
          ]})
      Mediator.read_spec(@params.merge(exec: "５五と")).should == ["５五と(45)", "５五と"]
    end

    it "右下だけ" do
      @params.update({init: [
            "______", "______", "______",
            "______", "______", "______",
            "______", "______", "４六と",
          ]})
      Mediator.read_spec(@params.merge(exec: "５五と")).should == ["５五と(46)", "５五と"]
    end

    it "真下だけ" do
      @params.update({init: [
            "______", "______", "______",
            "______", "______", "______",
            "______", "５六と", "______",
          ]})
      Mediator.read_spec(@params.merge(exec: "５五と")).should == ["５五と(56)", "５五と"]
    end

    it "下面" do
      @params.update({init: [
            "______", "______", "______",
            "______", "______", "______",
            "６六と", "５六と", "４六と",
          ]})
      Mediator.read_spec(@params.merge(exec: "５五と右")).should == ["５五と(46)", "５五と右"]
      Mediator.read_spec(@params.merge(exec: "５五と直")).should == ["５五と(56)", "５五と直"]
      Mediator.read_spec(@params.merge(exec: "５五と左")).should == ["５五と(66)", "５五と左"]
    end

    it "左下と下" do
      @params.update({init: [
            "______", "______", "______",
            "______", "______", "______",
            "６六と", "５六と", "______",
          ]})
      Mediator.read_spec(@params.merge(exec: "５五と左")).should == ["５五と(66)", "５五と左"]
      Mediator.read_spec(@params.merge(exec: "５五と直")).should == ["５五と(56)", "５五と直"]
    end

    it "縦に二つ" do
      @params.update({init: [
            "______", "５四と", "______",
            "______", "______", "______",
            "______", "５六と", "______",
          ]})
      Mediator.read_spec(@params.merge(exec: "５五と引")).should == ["５五と(54)", "５五と引"]
      Mediator.read_spec(@params.merge(exec: "５五と上")).should == ["５五と(56)", "５五と上"]
    end

    it "左と左下" do
      @params.update({init: [
            "______", "______", "______",
            "６五と", "______", "______",
            "６六と", "______", "______",
          ]})
      Mediator.read_spec(@params.merge(exec: "５五と寄")).should == ["５五と(65)", "５五と寄"]
      Mediator.read_spec(@params.merge(exec: "５五と上")).should == ["５五と(66)", "５五と上"]
    end

    it "左上と左下" do
      @params.update({init: [
            "６四銀", "______", "______",
            "______", "______", "______",
            "６六銀", "______", "______",
          ]})
      Mediator.read_spec(@params.merge(exec: "５五銀引")).should == ["５五銀(64)", "５五銀引"]
      Mediator.read_spec(@params.merge(exec: "５五銀上")).should == ["５五銀(66)", "５五銀上"]
    end

    it "左右" do
      @params.update({init: [
            "______", "______", "______",
            "６五と", "______", "４五と",
            "______", "______", "______",
          ]})
      Mediator.read_spec(@params.merge(exec: "５五と左")).should == ["５五と(65)", "５五と左"]
      Mediator.read_spec(@params.merge(exec: "５五と右")).should == ["５五と(45)", "５五と右"]
    end

    describe "打" do
      it "基本表示しない" do
        @params.update({init: [
              "______", "______", "______",
              "______", "______", "______",
              "______", "______", "______",
            ]})
        Mediator.read_spec(@params.merge(exec: "５五銀")).should == ["５五銀打", "５五銀"]
      end

      it "盤上の駒1つ移動と重複するため明示" do
        @params.update({init: [
              "______", "______", "______",
              "______", "______", "______",
              "______", "５六銀", "______",
            ]})
        Mediator.read_spec(@params.merge(exec: "５五銀打")).should == ["５五銀打", "５五銀打"]
      end

      it "盤上の駒2つ以上の移動と重複するため明示(盤上の重複の解決処理と打の関係)" do
        @params.update({init: [
              "______", "______", "______",
              "______", "______", "______",
              "６六銀", "５六銀", "______",
            ]})
        Mediator.read_spec(@params.merge(exec: "５五銀打")).should == ["５五銀打", "５五銀打"]
      end
    end

    it "直と不成が重なるとき「不成」と「直」の方が先にくる" do
      Mediator.read_spec(init: ["３四銀", "２四銀"], exec: "２三銀直不成").should == ["２三銀(24)", "２三銀直不成"]
    end

    it "２三銀引成できる" do
      Mediator.read_spec(init: ["３二銀", "３四銀"], exec: "２三銀引成").should == ["２三銀成(32)", "２三銀引成"]
    end

    it "「直上」ではなく「直」になる" do
      Mediator.read_spec(init: ["２九金", "１九金"], exec: "２八金直").should == ["２八金(29)", "２八金直"]
    end
  end
end
