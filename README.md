# le_bdf
## Simple English
manipulate BDF class in Liberty Eiffel

## 日本語での説明
BDFファイルをビットマップにするLiberty Eiffel[^othereiffel]のクラス(bdf.e)です。
説明は面倒になったので、サンプルのbdf_test.eを見てください。

というのもあんまりですからもうちょっと説明。
より正確にはgetopt_longっぽいことをするためのクラスです。getopt_longについては

    man 3 getopt_long

でどうぞ。以下の動作例にもあるように、getoptを呼び出すとargument(i)は破壊されますのでご注意を（参考にしたCライブラリのgetopt_long/getoptもそういう動作だと思いますが、、、）

### 動作例
bdf_test.eをコンパイルして、コマンドライン引数として適切なbdfファイルを与えるとこんな感じの結果になります。

    816
    No glyph!
    No glyph!
    No glyph!
    No glyph!
    No glyph!
    
    72 00000048
    00000000
    10000010
    10000010
    10000010
    10000010
    10000010
    10000010
    11111110
    10000010
    10000010
    10000010
    10000010
    10000010
    10000010
    00000000
    00000000
    
    
    105 00000069
    00000000
    00010000
    00010000
    00000000
    00000000
    00110000
    00010000
    00010000
    00010000
    00010000
    00010000
    00010000
    00010000
    00010000
    00000000
    00000000
    
    
    33 00000021
    00000000
    00011000
    00011000
    00011000
    00011000
    00010000
    00010000
    00010000
    00010000
    00010000
    00010000
    00000000
    00000000
    00010000
    00010000
    00000000
    
遠くから/目を細めて見れば、"Hi!"と表示されているのが見えるのではないでしょうか。（上記の例は東雲フォント8x16aです。）