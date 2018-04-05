# frozen-string-literal: true

module Warabi
  class WarabiError < StandardError
  end

  # ありえない処理
  class MustNotHappen < WarabiError
  end

  # 盤上に得体の知れないものがいる
  class UnconfirmedObject < WarabiError
  end

  # 指定座標に移動できる駒が一つもない (KI2の場合でのみ)
  class MovableBattlerNotFound < WarabiError
  end

  # 指定座標に移動できる駒が多すぎる
  class AmbiguousFormatError < WarabiError
  end

  # 指定の名前の駒が存在しない
  class PieceNotFound < WarabiError
  end

  # 指定の持駒が無い
  class HoldPieceNotFound < WarabiError
  end

  # 指定の持駒が無い(打を省略からの)
  class HoldPieceNotFound2 < WarabiError
  end

  # 自分の駒の上に自分の駒を初期配置
  class PieceAlredyExist < WarabiError
  end

  # 盤面に指定した駒がない
  class PieceNotFoundOnBoard < WarabiError
  end

  # すでに成っている
  class AlredyPromoted < WarabiError
  end

  # ファイルのフォーマットがおかしい
  class FileFormatError < WarabiError
  end

  # 手合割・囲い・戦型などのあるはずのデータがない
  class KeyNotFound < WarabiError
  end

  # スタックが空
  class MementoStackEmpty < WarabiError
  end

  ################################################################################ 構文系 (SyntaxDefact)

  # 構文エラー
  class SyntaxDefact < WarabiError
  end

  # 「同」に対する座標が不明
  class BeforePlaceNotFound < SyntaxDefact
  end

  # 「２二角打」または「２二角」(打の省略形)とするところを「２二角成打」と書いている
  class IllegibleFormat < SyntaxDefact
  end

  # "同歩" だけでいいのに "２四同歩" と場所を明示したとき、その前の指し手が "２四○" でない
  class SamePlaceDifferent < SyntaxDefact
  end

  ################################################################################ ルール系 (RuleError) 人間同士で指すと現われる反則。しかし公式の棋譜には残らないグループ

  class RuleError < SyntaxDefact
    def initialize(message)
      super "【反則】#{message}"
    end
  end

  # 別に問題ないけど将棋のルール上エラーとするもの

  # 死に駒
  class DeadPieceRuleError < RuleError
  end

  # 成れない駒を成った
  class NoPromotablePiece < RuleError
  end

  # ２七に歩がないのに２六歩(27)とした
  class NotFoundOnBoard < RuleError
  end

  # 指定座標に移動できる駒に移動元の駒が含まれていない。初手25歩(27)の場合
  class CandidateSoldiersNotInclude < RuleError
  end

  # 成れない条件で成ろうとする。初手７六歩成など
  class NotPromotable < RuleError
  end

  # 成った状態で打とうとした
  class PromotedPiecePutOnError < RuleError
  end

  # 成駒を成ってない状態に戻そうとした
  class PromotedPieceToNormalPiece < RuleError
  end

  # 自分の駒の上に自分の駒を指した。初手 "８八飛(28)" など
  class SamePlayerBattlerOverwrideError < RuleError
  end

  # 相手の駒を動かそうとした。▲の手番で初手 "３四歩"
  class ReversePlayerPieceMoveError < RuleError
  end

  ################################################################################ 棋譜にも残る場合がある反則 (CommonError)

  # パース時にオプションで例外を抑制できる反則
  class CommonError < RuleError
  end

  # 二歩
  class DoublePawnCommonError < CommonError
  end

  # 手番が異なる
  class DifferentTurnCommonError < CommonError
  end
end
