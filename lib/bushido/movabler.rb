# frozen-string-literal: true
#
# 動けるか確認
#   どのクラスでも使うので
#   どのクラスに入れたらいいのかわからん
#   ので別のモジュールにしてみる
#
module Bushido
  module Movabler
    extend self

    # player の mini_soldier が移動可能な手をすべて取得する
    #
    # アルゴリズム
    #
    #     １       １
    #   +---+    +---+
    #   | ・|一  | ・|一
    #   | ・|二  | ・|二
    #   | 香|三  | 杏|三
    #   +---+    +---+
    #
    #   ▲１三香の場合
    #   A. "１二" に移動してみて、その状態でさらに動けるなら "１二香" をストアしつつ、成れるなら成ってさらに動けるなら "１二杏" もストア
    #   B. "１一" に移動してみて、その状態でさらに動けるなら "１一杏" をストアしつつ、成れるなら成ってさらに動けるなら "１三杏" をストア
    #
    #   ▲１三杏 の場合
    #   C. "１二" に移動してみて、その状態でさらに動けるなら "１二杏" をストア。動けないので成れるなら成って→成れない
    #   D. "１一" に移動してみて → 移動できない
    #
    #   となるので成っているかどうかにかかわらず B の方法でやればいい
    #
    def movable_infos(player, mini_soldier, options = {})
      vecs = mini_soldier[:piece].select_vectors(mini_soldier[:promoted])
      infos = normalized_vectors(player.location, vecs).each.with_object([]) do |vec, infos|
        pt = mini_soldier[:point]
        loop do
          pt = pt.vector_add(vec) # １三香 → １二香
          unless pt.valid?        # １三香 → １三香 の場合、それ以上動けないのでbreakする
            break
          end
          target = player.board.lookup(pt)
          if target.nil?         # 「１二」に何もないなら
            piece_store(infos, player, mini_soldier, pt) # 駒を置く
          else
            unless target.kind_of?(Soldier)
              raise UnconfirmedObject, "得体の知れないものが盤上にいます : #{target.inspect}"
            end
            # 自分の駒は追い抜けない(駒の所有者が自分だったので追い抜けない)
            if target.player == player
              break
            else
              # 相手の駒だったので置ける
              piece_store(infos, player, mini_soldier, pt)
              break
            end
          end
          # 繰り返しベクトルでなければ一つ動いて終わり
          if vec.kind_of?(OnceVector)
            break
          end
        end
      end

      # infos.each{|e|e.update(origin_soldier: mini_soldier)}
      infos.uniq{|e|e.to_s} # FIXME: 高速化の余地あり
    end

    # player の mini_soldier が vecs の方向(複数)へ移動できるか？
    #  ・とてもシンプル
    #  ・相手の盤上の駒を考慮しない
    #  ・自分の盤上の駒も考慮しない
    #  ・さらに成れるかどうか考慮しない
    #  ・桂を1の行にジャンプしたときにそれ以上移動できないので「１一桂」はダメという場合に使う
    #  ・だから OnceVector か RepeatVector か見る必要はない
    #  ・行ける方向に一歩でも行ける可能性があればよい
    def alive_piece?(mini_soldier)
      raise MustNotHappen unless mini_soldier[:location]
      vectors = mini_soldier[:piece].select_vectors(mini_soldier[:promoted])
      normalized_vectors(mini_soldier[:location], vectors).any? do |v|
        mini_soldier[:point].vector_add(v).valid?
      end
    end

    private

    # pt の場所は空なので player の mini_soldier を pt に置けそうだ
    # でも pt に置いてそれ以上動けなかったら反則になるので
    # 1. それ以上動けるなら置く
    # 2. 成れるなら成ってみて、それ以上動けるなら置く
    def piece_store(infos, player, mini_soldier, pt)
      # それ以上動けるなら置く
      m = mini_soldier.merge(point: pt)
      if alive_piece?(m)
        infos << SoldierMove[m.merge(origin_soldier: mini_soldier)]
      end
      # 成れるなら成ってみて
      if m.more_promote?(player.location)
        m = m.merge(promoted: true)
        # それ以上動けるなら置く
        if alive_piece?(m)
          infos << SoldierMove[m.merge(origin_soldier: mini_soldier, promoted_trigger: true)]
        end
      end
    end

    def normalized_vectors(location, vecs)
      if location.white?
        vecs.collect(&:reverse_sign)
      else
        vecs
      end
    end
  end
end
