require 'win32ole'

#URL入力フォーム
def UrlInputForm(default)
  #win32oleのScriptControlオブジェクト生成
  wsh = WIN32OLE.new 'ScriptControl'
  #言語の指定(VBS)
  wsh.language = 'VBScript'
  #入力フォームの表示＆入力された文字列を変数strに格納
  str = wsh.eval(%Q!InputBox("TootするインスタンスのURL","にゃーんボタン","#{default}")!)
  return str
end

#token入力フォーム
def TokenInputForm(default)
    #win32oleのScriptControlオブジェクト生成
    wsh = WIN32OLE.new 'ScriptControl'
    #言語の指定(VBS)
    wsh.language = 'VBScript'
    #入力フォームの表示＆入力された文字列を変数strに格納
    str = wsh.eval(%Q!InputBox("アクセストークンを入力してください","にゃーんボタン","#{default}")!)
    return str
end