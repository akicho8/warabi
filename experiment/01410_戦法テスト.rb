require "./example_helper"

rows = TacticInfo.all_elements.collect do |e|
  file = Pathname.glob("#{e.tactic_info.name}/#{e.key}.{kif,ki2}").first
  row = {key: e.key, file: file.to_s}
  if file
    str = file.read
    info = Parser.parse(str)
    info.mediator_run
    row[:matches] = info.mediator.players.collect { |player|
      player.skill_set.public_send(e.tactic_info.list_key).normalize.collect(&:key)
    }.flatten
    row[:status] = row[:matches].include?(e.key)
  end
  row
end
tp rows
# >> |----------------------+-------------------------------+------------------------------------------------------------------------------------+--------|
# >> | key                  | file                          | matches                                                                            | status |
# >> |----------------------+-------------------------------+------------------------------------------------------------------------------------+--------|
# >> | カニ囲い             | 囲い/カニ囲い.kif             | [:カニ囲い]                                                                        | true   |
# >> | 金矢倉               | 囲い/金矢倉.kif               | [:金矢倉]                                                                          | true   |
# >> | 銀矢倉               | 囲い/銀矢倉.kif               | [:銀矢倉]                                                                          | true   |
# >> | 片矢倉               | 囲い/片矢倉.kif               | [:片矢倉]                                                                          | true   |
# >> | 総矢倉               | 囲い/総矢倉.kif               | [:総矢倉]                                                                          | true   |
# >> | 矢倉穴熊             | 囲い/矢倉穴熊.kif             | [:金矢倉, :矢倉穴熊, :カニ囲い, :総矢倉]                                           | true   |
# >> | 菊水矢倉             | 囲い/菊水矢倉.kif             | [:菊水矢倉, :カニ囲い, :菊水矢倉]                                                  | true   |
# >> | 銀立ち矢倉           | 囲い/銀立ち矢倉.kif           | [:舟囲い, :左美濃, :銀立ち矢倉, :高美濃囲い]                                       | true   |
# >> | 菱矢倉               | 囲い/菱矢倉.kif               | [:総矢倉, :菱矢倉]                                                                 | true   |
# >> | 雁木囲い             | 囲い/雁木囲い.kif             | [:総矢倉, :雁木囲い]                                                               | true   |
# >> | ボナンザ囲い         | 囲い/ボナンザ囲い.kif         | [:片美濃囲い, :ボナンザ囲い, :片矢倉]                                              | true   |
# >> | 矢倉早囲い           | 囲い/矢倉早囲い.kif           | [:矢倉早囲い]                                                                      | true   |
# >> | 美濃囲い             | 囲い/美濃囲い.kif             | [:美濃囲い]                                                                        | true   |
# >> | 高美濃囲い           | 囲い/高美濃囲い.kif           | [:舟囲い, :高美濃囲い]                                                             | true   |
# >> | 銀冠                 | 囲い/銀冠.kif                 | [:銀冠]                                                                            | true   |
# >> | 銀美濃               | 囲い/銀美濃.kif               | [:銀美濃]                                                                          | true   |
# >> | ダイヤモンド美濃     | 囲い/ダイヤモンド美濃.kif     | [:ダイヤモンド美濃, :舟囲い]                                                       | true   |
# >> | 木村美濃             | 囲い/木村美濃.kif             | [:金矢倉, :木村美濃]                                                               | true   |
# >> | 片美濃囲い           | 囲い/片美濃囲い.kif           | [:片美濃囲い]                                                                      | true   |
# >> | ちょんまげ美濃       | 囲い/ちょんまげ美濃.kif       | [:ちょんまげ美濃]                                                                  | true   |
# >> | 坊主美濃             | 囲い/坊主美濃.kif             | [:坊主美濃, :いちご囲い]                                                           | true   |
# >> | 金美濃               | 囲い/金美濃.kif               | [:金美濃]                                                                          | true   |
# >> | 左美濃               | 囲い/左美濃.kif               | [:舟囲い, :左美濃]                                                                 | true   |
# >> | 天守閣美濃           | 囲い/天守閣美濃.kif           | [:美濃囲い, :舟囲い, :天守閣美濃]                                                  | true   |
# >> | 四枚美濃             | 囲い/四枚美濃.kif             | [:美濃囲い, :舟囲い, :天守閣美濃, :四枚美濃]                                       | true   |
# >> | 端玉銀冠             | 囲い/端玉銀冠.kif             | [:左美濃, :端玉銀冠, :美濃囲い, :銀冠]                                             | true   |
# >> | 串カツ囲い           | 囲い/串カツ囲い.kif           | [:舟囲い, :串カツ囲い]                                                             | true   |
# >> | 舟囲い               | 囲い/舟囲い.kif               | [:舟囲い]                                                                          | true   |
# >> | 居飛車穴熊           | 囲い/居飛車穴熊.kif           | [:居飛車穴熊]                                                                      | true   |
# >> | 松尾流穴熊           | 囲い/松尾流穴熊.kif           | [:松尾流穴熊]                                                                      | true   |
# >> | 銀冠穴熊             | 囲い/銀冠穴熊.kif             | [:左美濃, :銀冠穴熊, :高美濃囲い, :銀冠]                                           | true   |
# >> | ビッグ４             | 囲い/ビッグ４.kif             | [:銀冠穴熊, :ビッグ４]                                                             | true   |
# >> | 箱入り娘             | 囲い/箱入り娘.kif             | [:箱入り娘]                                                                        | true   |
# >> | ミレニアム囲い       | 囲い/ミレニアム囲い.kif       | [:ミレニアム囲い]                                                                  | true   |
# >> | 振り飛車穴熊         | 囲い/振り飛車穴熊.kif         | [:舟囲い, :振り飛車穴熊]                                                           | true   |
# >> | 右矢倉               | 囲い/右矢倉.kif               | [:右矢倉]                                                                          | true   |
# >> | 金無双               | 囲い/金無双.kif               | [:金無双]                                                                          | true   |
# >> | 中住まい             | 囲い/中住まい.kif             | [:中住まい]                                                                        | true   |
# >> | 中原玉               | 囲い/中原玉.kif               | [:中原玉]                                                                          | true   |
# >> | アヒル囲い           | 囲い/アヒル囲い.kif           | [:中住まい, :アヒル囲い, :中原玉]                                                  | true   |
# >> | いちご囲い           | 囲い/いちご囲い.kif           | [:いちご囲い]                                                                      | true   |
# >> | 無敵囲い             | 囲い/無敵囲い.kif             | [:無敵囲い]                                                                        | true   |
# >> | elmo囲い             | 囲い/elmo囲い.kif             | [:elmo囲い]                                                                        | true   |
# >> | 左山囲い             | 囲い/左山囲い.kif             | [:左山囲い]                                                                        | true   |
# >> | 無責任矢倉           | 囲い/無責任矢倉.kif           | [:無責任矢倉]                                                                      | true   |
# >> | ツノ銀雁木           | 囲い/ツノ銀雁木.kif           | [:ツノ銀雁木]                                                                      | true   |
# >> | ３七銀戦法           | 戦型/３七銀戦法.kif           | [:３七銀戦法, :阿久津流急戦矢倉]                                                   | true   |
# >> | 脇システム           | 戦型/脇システム.kif           | [:３七銀戦法, :脇システム, :矢倉棒銀, :棒銀, :右四間飛車]                          | true   |
# >> | 矢倉棒銀             | 戦型/矢倉棒銀.kif             | [:矢倉棒銀, :棒銀, :四手角]                                                        | true   |
# >> | 森下システム         | 戦型/森下システム.kif         | [:袖飛車, :森下システム]                                                           | true   |
# >> | 雀刺し               | 戦型/雀刺し.kif               | [:雀刺し, :袖飛車]                                                                 | true   |
# >> | 米長流急戦矢倉       | 戦型/米長流急戦矢倉.kif       | [:米長流急戦矢倉]                                                                  | true   |
# >> | カニカニ銀           | 戦型/カニカニ銀.kif           | [:カニカニ銀, :右四間飛車]                                                         | true   |
# >> | 中原流急戦矢倉       | 戦型/中原流急戦矢倉.kif       | [:袖飛車, :中原流急戦矢倉]                                                         | true   |
# >> | 阿久津流急戦矢倉     | 戦型/阿久津流急戦矢倉.kif     | [:３七銀戦法, :阿久津流急戦矢倉]                                                   | true   |
# >> | 矢倉中飛車           | 戦型/矢倉中飛車.kif           | [:相振り飛車, :矢倉中飛車, :原始中飛車, :ゴキゲン中飛車, :矢倉中飛車, :相振り飛車] | true   |
# >> | 右四間飛車           | 戦型/右四間飛車.kif           | [:新丸山ワクチン, :右四間飛車, :ゴキゲン中飛車]                                    | true   |
# >> | 原始棒銀             | 戦型/原始棒銀.kif             | [:原始棒銀, :角換わり棒銀, :棒銀]                                                  | true   |
# >> | 右玉                 | 戦型/右玉.kif                 | [:角換わり腰掛け銀, :右玉]                                                         | true   |
# >> | かまいたち戦法       | 戦型/かまいたち戦法.kif       | [:超急戦, :ゴキゲン中飛車, :角交換振り飛車, :かまいたち戦法]                       | true   |
# >> | パックマン戦法       | 戦型/パックマン戦法.ki2       | [:パックマン戦法]                                                                  | true   |
# >> | 新米長玉             | 戦型/新米長玉.ki2             | [:新米長玉]                                                                        | true   |
# >> | 稲庭戦法             | 戦型/稲庭戦法.ki2             | [:嬉野流, :稲庭戦法]                                                               | true   |
# >> | 四手角               | 戦型/四手角.kif               | [:袖飛車, :四手角]                                                                 | true   |
# >> | 一間飛車             | 戦型/一間飛車.kif             | [:一間飛車]                                                                        | true   |
# >> | 一間飛車穴熊         | 戦型/一間飛車穴熊.ki2         | [:一間飛車穴熊]                                                                    | true   |
# >> | 都成流               | 戦型/都成流.ki2               | [:都成流]                                                                          | true   |
# >> | 右四間飛車左美濃     | 戦型/右四間飛車左美濃.kif     | [:袖飛車, :右四間飛車, :右四間飛車左美濃]                                          | true   |
# >> | 角換わり             | 戦型/角換わり.kif             | [:角交換振り飛車, :角換わり]                                                       | true   |
# >> | 角換わり腰掛け銀     | 戦型/角換わり腰掛け銀.kif     | [:角換わり早繰り銀, :角換わり腰掛け銀, :右四間飛車]                                | true   |
# >> | 角換わり棒銀         | 戦型/角換わり棒銀.kif         | [:原始棒銀, :角換わり棒銀, :棒銀]                                                  | true   |
# >> | 角換わり早繰り銀     | 戦型/角換わり早繰り銀.kif     | [:角換わり早繰り銀, :角換わり腰掛け銀, :右四間飛車]                                | true   |
# >> | 筋違い角             | 戦型/筋違い角.kif             | [:筋違い角]                                                                        | true   |
# >> | 木村定跡             | 戦型/木村定跡.kif             | [:木村定跡, :角換わり腰掛け銀]                                                     | true   |
# >> | 一手損角換わり       | 戦型/一手損角換わり.kif       | [:英ちゃん流中飛車, :向かい飛車, :対振り持久戦, :一手損角換わり]                   | true   |
# >> | 相掛かり             | 戦型/相掛かり.kif             | [:相掛かり, :相掛かり棒銀]                                                         | true   |
# >> | 相掛かり棒銀         | 戦型/相掛かり棒銀.ki2         | [:相掛かり, :相掛かり棒銀]                                                         | true   |
# >> | 塚田スペシャル       | 戦型/塚田スペシャル.kif       | [:相掛かり, :塚田スペシャル]                                                       | true   |
# >> | 中原流相掛かり       | 戦型/中原流相掛かり.kif       | [:相掛かり, :中原流相掛かり, :腰掛け銀]                                            | true   |
# >> | 中原飛車             | 戦型/中原飛車.kif             | [:横歩取り, :△３三角型空中戦法, :８五飛車戦法, :中原飛車]                         | true   |
# >> | 腰掛け銀             | 戦型/腰掛け銀.kif             | [:腰掛け銀, :右四間飛車, :四間飛車]                                                | true   |
# >> | 鎖鎌銀               | 戦型/鎖鎌銀.kif               | [:鎖鎌銀, :ゴキゲン中飛車]                                                         | true   |
# >> | ８五飛車戦法         | 戦型/８五飛車戦法.kif         | [:横歩取り, :△３三角型空中戦法, :８五飛車戦法]                                    | true   |
# >> | UFO銀                | 戦型/UFO銀.ki2                | [:相掛かり, :相掛かり棒銀, :UFO銀]                                                 | true   |
# >> | 横歩取り             | 戦型/横歩取り.kif             | [:横歩取り, :△３三桂戦法]                                                         | true   |
# >> | △３三角型空中戦法   | 戦型/△３三角型空中戦法.kif   | [:横歩取り, :△３三角型空中戦法]                                                   | true   |
# >> | △３三桂戦法         | 戦型/△３三桂戦法.kif         | [:横歩取り, :△３三桂戦法]                                                         | true   |
# >> | △２三歩戦法         | 戦型/△２三歩戦法.kif         | [:△２三歩戦法, :一手損角換わり]                                                   | true   |
# >> | △４五角戦法         | 戦型/△４五角戦法.kif         | [:横歩取り, :△４五角戦法]                                                         | true   |
# >> | 相横歩取り           | 戦型/相横歩取り.kif           | [:横歩取り, :相横歩取り]                                                           | true   |
# >> | ゴキゲン中飛車       | 戦型/ゴキゲン中飛車.kif       | [:超急戦, :ゴキゲン中飛車, :角交換振り飛車]                                        | true   |
# >> | ツノ銀中飛車         | 戦型/ツノ銀中飛車.kif         | [:英ちゃん流中飛車, :ツノ銀中飛車, :４五歩早仕掛け, :加藤流袖飛車, :袖飛車]        | true   |
# >> | 平目                 | 戦型/平目.kif                 | [:ゴキゲン中飛車, :平目, :対振り持久戦]                                            | true   |
# >> | 風車                 | 戦型/風車.kif                 | [:右玉, :風車]                                                                     | true   |
# >> | 新風車               | 戦型/新風車.ki2               | [:右玉, :新風車]                                                                   | true   |
# >> | 英ちゃん流中飛車     | 戦型/英ちゃん流中飛車.kif     | [:英ちゃん流中飛車]                                                                | true   |
# >> | 原始中飛車           | 戦型/原始中飛車.kif           | [:相振り飛車, :矢倉中飛車, :原始中飛車, :ゴキゲン中飛車, :矢倉中飛車, :相振り飛車] | true   |
# >> | 加藤流袖飛車         | 戦型/加藤流袖飛車.kif         | [:英ちゃん流中飛車, :加藤流袖飛車, :袖飛車, :棒銀]                                 | true   |
# >> | ５七金戦法           | 戦型/５七金戦法.kif           | [:三間飛車, :５七金戦法]                                                           | true   |
# >> | 超急戦               | 戦型/超急戦.kif               | [:超急戦, :ゴキゲン中飛車]                                                         | true   |
# >> | 中飛車左穴熊         | 戦型/中飛車左穴熊.kif         | [:矢倉中飛車, :ゴキゲン中飛車, :原始中飛車, :中飛車左穴熊]                         | true   |
# >> | 遠山流               | 戦型/遠山流.kif               | [:遠山流, :ゴキゲン中飛車, :角交換振り飛車, :遠山流]                               | true   |
# >> | 四間飛車             | 戦型/四間飛車.kif             | [:袖飛車, :四間飛車]                                                               | true   |
# >> | 藤井システム         | 戦型/藤井システム.kif         | [:四間飛車, :藤井システム, :袖飛車]                                                | true   |
# >> | 立石流               | 戦型/立石流.kif               | [:５筋位取り, :四間飛車, :立石流]                                                  | true   |
# >> | レグスペ             | 戦型/レグスペ.kif             | [:角換わり腰掛け銀, :レグスペ, :角換わり腰掛け銀, :右四間飛車, :右四間飛車急戦]    | true   |
# >> | 三間飛車             | 戦型/三間飛車.kif             | [:三間飛車, :棒金]                                                                 | true   |
# >> | 石田流               | 戦型/石田流.kif               | [:石田流]                                                                          | true   |
# >> | 早石田               | 戦型/早石田.kif               | [:早石田, :玉頭位取り]                                                             | true   |
# >> | 升田式石田流         | 戦型/升田式石田流.kif         | [:升田式石田流, :一手損角換わり, :陽動振り飛車]                                    | true   |
# >> | 鬼殺し               | 戦型/鬼殺し.kif               | [:鬼殺し, :相振り飛車, :５筋位取り, :早石田, :石田流]                              | true   |
# >> | △３ニ飛戦法         | 戦型/△３ニ飛戦法.kif         | [:早石田, :４→３戦法, :△３ニ飛戦法, :相振り飛車]                                 | true   |
# >> | 中田功XP             | 戦型/中田功XP.ki2             | [:対振り持久戦, :中田功XP]                                                         | true   |
# >> | 真部流               | 戦型/真部流.kif               | [:対振り持久戦, :三間飛車, :真部流]                                                | true   |
# >> | ▲７八飛戦法         | 戦型/▲７八飛戦法.ki2         | [:▲７八飛戦法]                                                                    | true   |
# >> | ４→３戦法           | 戦型/４→３戦法.kif           | [:対振り持久戦, :袖飛車, :四間飛車, :三間飛車, :４→３戦法, :向かい飛車]           | true   |
# >> | 楠本式石田流         | 戦型/楠本式石田流.kif         | [:三間飛車, :楠本式石田流, :対振り持久戦]                                          | true   |
# >> | 新石田流             | 戦型/新石田流.kif             | [:三間飛車, :新石田流]                                                             | true   |
# >> | 新鬼殺し             | 戦型/新鬼殺し.kif             | [:新鬼殺し]                                                                        | true   |
# >> | ダイレクト向かい飛車 | 戦型/ダイレクト向かい飛車.kif | [:ダイレクト向かい飛車]                                                            | true   |
# >> | 向かい飛車           | 戦型/向かい飛車.kif           | [:５筋位取り, :向かい飛車]                                                         | true   |
# >> | メリケン向かい飛車   | 戦型/メリケン向かい飛車.kif   | [:向かい飛車, :メリケン向かい飛車, :対振り持久戦]                                  | true   |
# >> | 阪田流向飛車         | 戦型/阪田流向飛車.kif         | [:ダイレクト向かい飛車, :阪田流向飛車]                                             | true   |
# >> | 角頭歩戦法           | 戦型/角頭歩戦法.kif           | [:角頭歩戦法]                                                                      | true   |
# >> | 鬼殺し向かい飛車     | 戦型/鬼殺し向かい飛車.kif     | [:丸山ワクチン, :角換わり, :ゴキゲン中飛車, :鬼殺し向かい飛車]                     | true   |
# >> | 陽動振り飛車         | 戦型/陽動振り飛車.kif         | [:矢倉中飛車, :ゴキゲン中飛車, :陽動振り飛車]                                      | true   |
# >> | 玉頭銀               | 戦型/玉頭銀.kif               | [:玉頭位取り, :玉頭銀, :原始棒銀, :棒銀]                                           | true   |
# >> | つくつくぼうし戦法   | 戦型/つくつくぼうし戦法.kif   | [:相掛かり, :腰掛け銀, :つくつくぼうし戦法]                                        | true   |
# >> | ひねり飛車           | 戦型/ひねり飛車.kif           | [:相掛かり, :ひねり飛車]                                                           | true   |
# >> | 相振り飛車           | 戦型/相振り飛車.kif           | [:ゴキゲン中飛車, :相振り飛車, :四間飛車]                                          | true   |
# >> | 角交換振り飛車       | 戦型/角交換振り飛車.kif       | [:角交換振り飛車]                                                                  | true   |
# >> | きｍきｍ金           | 戦型/きｍきｍ金.kif           | [:早石田, :きｍきｍ金]                                                             | true   |
# >> | ポンポン桂           | 戦型/ポンポン桂.kif           | [:四間飛車, :対振り持久戦, :ポンポン桂]                                            | true   |
# >> | ５筋位取り           | 戦型/５筋位取り.kif           | [:５筋位取り, :向かい飛車]                                                         | true   |
# >> | 玉頭位取り           | 戦型/玉頭位取り.kif           | [:玉頭位取り, :玉頭銀, :原始棒銀, :棒銀]                                           | true   |
# >> | 地下鉄飛車           | 戦型/地下鉄飛車.kif           | [:四間飛車, :対振り持久戦, :地下鉄飛車]                                            | true   |
# >> | 飯島流引き角戦法     | 戦型/飯島流引き角戦法.kif     | [:三間飛車, :飯島流引き角戦法, :袖飛車]                                            | true   |
# >> | 丸山ワクチン         | 戦型/丸山ワクチン.kif         | [:丸山ワクチン, :ゴキゲン中飛車]                                                   | true   |
# >> | 新丸山ワクチン       | 戦型/新丸山ワクチン.kif       | [:新丸山ワクチン, :ゴキゲン中飛車]                                                 | true   |
# >> | ４六銀左急戦         | 戦型/４六銀左急戦.kif         | [:四間飛車, :藤井システム, :４→３戦法, :４六銀左急戦, :袖飛車]                    | true   |
# >> | ４五歩早仕掛け       | 戦型/４五歩早仕掛け.kif       | [:４五歩早仕掛け]                                                                  | true   |
# >> | 鷺宮定跡             | 戦型/鷺宮定跡.kif             | [:鷺宮定跡, :袖飛車, :四間飛車, :藤井システム]                                     | true   |
# >> | 棒銀                 | 戦型/棒銀.kif                 | [:原始棒銀, :角換わり棒銀, :棒銀]                                                  | true   |
# >> | ４六銀右急戦         | 戦型/４六銀右急戦.kif         | [:四間飛車, :藤井システム, :４→３戦法, :４六銀右急戦, :袖飛車]                    | true   |
# >> | 左美濃急戦           | 戦型/左美濃急戦.kif           | [:左美濃急戦, :角換わり棒銀, :棒銀, :四間飛車, :４→３戦法]                        | true   |
# >> | 右四間飛車急戦       | 戦型/右四間飛車急戦.kif       | [:腰掛け銀, :右四間飛車, :右四間飛車急戦, :三間飛車, :四間飛車]                    | true   |
# >> | 鳥刺し               | 戦型/鳥刺し.kif               | [:四間飛車, :向かい飛車, :飯島流引き角戦法, :鳥刺し]                               | true   |
# >> | 嬉野流               | 戦型/嬉野流.kif               | [:鎖鎌銀, :嬉野流, :早石田, :石田流]                                               | true   |
# >> | 棒金                 | 戦型/棒金.kif                 | [:三間飛車, :棒金]                                                                 | true   |
# >> | 超速                 | 戦型/超速.kif                 | [:超速, :袖飛車, :玉頭位取り, :ゴキゲン中飛車]                                     | true   |
# >> | 対振り持久戦         | 戦型/対振り持久戦.kif         | [:対振り持久戦, :袖飛車, :四間飛車, :三間飛車, :４→３戦法, :向かい飛車]           | true   |
# >> | 高田流左玉           | 戦型/高田流左玉.kif           | [:向かい飛車, :相振り飛車, :高田流左玉, :向かい飛車]                               | true   |
# >> | ７二飛亜急戦         | 戦型/７二飛亜急戦.kif         | [:鷺宮定跡, :袖飛車, :７二飛亜急戦, :四間飛車, :４→３戦法]                        | true   |
# >> | 袖飛車               | 戦型/袖飛車.kif               | [:袖飛車, :四間飛車]                                                               | true   |
# >> | 一直線穴熊           | 戦型/一直線穴熊.kif           | [:対振り持久戦, :一直線穴熊, :袖飛車, :四間飛車, :腰掛け銀, :向かい飛車]           | true   |
# >> | 穴角戦法             | 戦型/穴角戦法.kif             | [:三間飛車, :四間飛車, :穴角戦法, :右四間飛車, :腰掛け銀, :対振り持久戦]           | true   |
# >> | 穴角向かい飛車       | 戦型/穴角向かい飛車.kif       | [:穴角向かい飛車]                                                                  | true   |
# >> | うっかり三間飛車     | 戦型/うっかり三間飛車.ki2     | [:うっかり三間飛車]                                                                | true   |
# >> | 菅井流三間飛車       | 戦型/菅井流三間飛車.kif       | [:菅井流三間飛車]                                                                  | true   |
# >> | アヒル戦法           | 戦型/アヒル戦法.kif           | [:アヒル戦法, :アヒル戦法]                                                         | true   |
# >> | 矢倉左美濃急戦       | 戦型/矢倉左美濃急戦.kif       | [:矢倉左美濃急戦, :右四間飛車]                                                     | true   |
# >> | 青野流               | 戦型/青野流.kif               | [:横歩取り, :青野流, :△３三角型空中戦法]                                          | true   |
# >> | 勇気流               | 戦型/勇気流.kif               | [:横歩取り, :勇気流, :△３三角型空中戦法]                                          | true   |
# >> |----------------------+-------------------------------+------------------------------------------------------------------------------------+--------|
