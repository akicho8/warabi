require_relative "spec_helper"

module Warabi
  describe Brain do
    describe "評価" do
      it "先手だけが歩を置いた状態" do
        Mediator.test3(init: "▲９七歩").players.collect{|e|e.evaluate}.should == [100, -100]
      end

      it "後手も歩を置いた状態" do
        Mediator.test3(init: "▲９七歩 △１三歩").players.collect{|e|e.evaluate}.should == [0, 0]
      end

      it "評価バー" do
        Mediator.test3(init: "▲９七歩").players.collect{|e|e.score_percentage(500)}.should == [60.0, 40.0]
      end

      describe "わかりにくい古いテスト" do
        it "先手だけが駒を持っている状態" do
          Mediator.player_test.evaluate.should == 22284
        end
        it "先手だけ駒を置いているとき" do
          Mediator.player_test(piece_plot: true).evaluate.should == 21699
        end
      end
    end

    describe "自動的に打つ" do
      it "ランダムに盤上の駒を動かす" do
        player = Mediator.player_test(piece_plot: true)
        player.brain.all_hands.sample.present?.should == true
      end
      it "全手筋" do
        player = Mediator.player_test(piece_plot: true)
        player.brain.all_hands.sort.should == ["▲９六歩(97)", "▲８六歩(87)", "▲７六歩(77)", "▲６六歩(67)", "▲５六歩(57)", "▲４六歩(47)", "▲３六歩(37)", "▲２六歩(27)", "▲１六歩(17)", "▲３八飛(28)", "▲４八飛(28)", "▲５八飛(28)", "▲６八飛(28)", "▲７八飛(28)", "▲１八飛(28)", "▲９八香(99)", "▲７八銀(79)", "▲６八銀(79)", "▲７八金(69)", "▲６八金(69)", "▲５八金(69)", "▲６八玉(59)", "▲５八玉(59)", "▲４八玉(59)", "▲５八金(49)", "▲４八金(49)", "▲３八金(49)", "▲４八銀(39)", "▲３八銀(39)", "▲１八香(19)"].sort
      end
    end

    it "盤上の駒の全手筋" do
      Board.size_change([1, 5]) do
        mediator = Mediator.test1(init: "▲１五香")
        mediator.player_at(:black).brain.__soldiers_hands.collect(&:to_kif).should == ["▲１四香(15)", "▲１三香(15)", "▲１三香成(15)", "▲１二香(15)", "▲１二香成(15)", "▲１一香成(15)"] # 入力文字列
      end
    end

    it "持駒の全手筋" do
      #
      # この状態↓から打てるのはこれ↓
      #
      #   ３ ２ １         ３ ２ １
      # +---------+      +---------+
      # | ・ ・ ・|一    | ・ ・ ・|一
      # | ・ 歩 ・|二 → | 歩 ・ 歩|二
      # | ・ ・ ・|三    | 歩 ・ 歩|三
      # +---------+      +---------+
      #
      Board.size_change([3, 3]) do
        player = Mediator.player_test(init: "２二歩", pieces_set: "歩")
        player.brain.__pieces_hands.collect(&:to_kif).should == ["▲３二歩打", "▲１二歩打", "▲３三歩打", "▲１三歩打"]
      end
    end

    it "一番得するように打つ" do
      Board.size_change([2, 2]) do
        mediator = Mediator.test3(init: "▲１二歩", pieces_set: "▲歩")
        mediator.player_at(:black).brain.score_list.should == [{:hand=>"▲１一歩成(12)", :score=>1305}, {:hand=>"▲２二歩打", :score=>200}]
      end
    end

    describe "NegaMax" do
      describe "自分の駒だけではなく相手の駒の状態も含めて戦況評価していることを確認するテスト(重要)" do
        it do
          Board.size_change([3, 3]) do
            mediator = Mediator.test3(init: "▲３三歩 △１一歩")
            # puts mediator.to_s.rstrip
            # 1手目: ▲先手番
            #   ３ ２ １
            # +---------+
            # | ・ ・v歩|一
            # | ・ ・ ・|二
            # | 歩 ・ ・|三
            # +---------+
            # ▲先手の持駒:
            # △後手の持駒:
            r = NegaMaxRunner.run(player: mediator.player_at(:black), depth: 1)
            r.should == {:hand => "▲３二歩成(33)", :score => 0, :level => 0, :reading_hands => ["▲３二歩成(33)", "△１二歩成(11)"]}
          end
        end
      end

      describe "戦況1" do
        def example1
          Board.size_change([2, 3]) do
            mediator = Mediator.test3(init: "▲１三飛 △１一香 △１二歩")
            yield mediator
          end
        end

        it "戦況1の確認" do
          example1 do |mediator|
            mediator.to_s.should == <<~EOT
後手の持駒：なし
  ２ １
+------+
| ・v香|一
| ・v歩|二
| ・ 飛|三
+------+
先手の持駒：なし
手数＝0 まで
EOT
          end
        end

        # 深さ
        # 0: ランダムに打って一番得になるものを選ぶため駒損を気にせず歩を取ってしまう
        # 1: 香車で取り返されることを予測するため回避する。またその場にいるだけでも取られるので２三に逃げる。また成った方が良いと判断する
        it do
          example1 {|mediator| NegaMaxRunner.run(player: mediator.player_at(:black), depth: 0)[:hand].should == "▲１二飛成(13)" }
          example1 {|mediator| NegaMaxRunner.run(player: mediator.player_at(:black), depth: 1)[:hand].should == "▲２三飛成(13)" }
        end
      end

      describe "戦況2" do
        def example2
          Board.disable_promotable do
            Board.size_change([2, 4]) do
              mediator = Mediator.test3(init: "△１一飛 △１二歩 ▲１三飛 ▲１四香")
              yield mediator
            end
          end
        end

        it "戦況2の確認" do
          example2 do |mediator|
            mediator.to_s.rstrip.should == <<-EOT.rstrip
後手の持駒：なし
  ２ １
+------+
| ・v飛|一
| ・v歩|二
| ・ 飛|三
| ・ 香|四
+------+
先手の持駒：なし
手数＝0 まで
EOT
          end
        end

        # 0: 最善手は歩と取ること
        # 1: 相手に飛車を取られて大損するため回避
        # 2: 香車で取り返せるのでやっぱり歩を取る筋で行く
        it { example2 {|mediator| NegaMaxRunner.run(player: mediator.player_at(:black), depth: 0)[:hand].should == "▲１二飛(13)" } }
        it { example2 {|mediator| NegaMaxRunner.run(player: mediator.player_at(:black), depth: 1)[:hand].should == "▲２三飛(13)" } }
        it { example2 {|mediator| NegaMaxRunner.run(player: mediator.player_at(:black), depth: 2)[:hand].should == "▲１二飛(13)" } }
      end
    end
  end
end
