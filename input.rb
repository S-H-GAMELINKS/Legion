require 'win32ole'

#Toot入力フォーム
def Toot(default)
    #win32oleのScriptControlオブジェクト生成
    wsh = WIN32OLE.new 'ScriptControl'
    #言語の指定(VBS)
    wsh.language = 'VBScript'
    #入力フォームの表示＆入力された文字列を変数strに格納
    str = wsh.eval(%Q!InputBox("Tootしたい内容を入力してください","Legion","#{default}")!)

    return str
end