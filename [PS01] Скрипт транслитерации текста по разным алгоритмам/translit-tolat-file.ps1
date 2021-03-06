##################################################################################
#
#
#  Script name: translit-tolat-file
#  Author:      lisnyak.taras@atbmarket.com
#
#
##################################################################################

<#
ОПИСАНИЕ:
ИМЯ: translit-tolat-file
Translate text from  txt File

ПАРАМЕТРЫ: 
-fpathIn          путь к искомому файлу (Обязательно)
-TraslitSchema    выбор транслитерации искомого файла (Опционально), по умолчанию gost-7-79-2000 _RU
-help        Вывод справки (Опционально)

СИНТАКСИС:

translit-tolat-file.ps1 -fpathIn C:\Script\Translit.txt  -TraslitSchema ru
Выполняет транслитерацию русского языка из файл Translit.csv в файл C:\Script\Translit.translate.
----------------------------------------------------------------------------------
translit-tolat-file -help
Показывает справку по этому скрипту (этот текст)
----------------------------------------------------------------------------------
#>

Param (
[parameter(Mandatory=$true)] 
[string]$fpathIn,
[string]$TraslitSchema
)


function global:TranslitToUALAT # http://zakon5.rada.gov.ua/laws/show/55-2010-%D0%BF
{
 	param([string]$inString)
	$Translit_To_LAT = @{ 
	[char]'а' = "a"
	[char]'А' = "A"
	[char]'б' = "b"
	[char]'Б' = "B"
	[char]'в' = "v"
	[char]'В' = "V"
	[char]'Ґ' = "h"
	[char]'ґ' = "H"
	[char]'Г' = "G"
    [char]'г' = "g"
	[char]'д' = "d"
	[char]'Д' = "D"
	[char]'е' = "e"
	[char]'Е' = "E"
	[char]'Є' = "Ye"
	[char]'є' = "ie"
	[char]'ж' = "zh"
	[char]'Ж' = "Zh"
	[char]'з' = "z"
	[char]'З' = "Z"
	[char]'и' = "y"
	[char]'И' = "Y"
	[char]'Ї' = "Yi"
	[char]'ї' = "i"
	[char]'Й' = "Y"
	[char]'й' = "i"
	[char]'к' = "k"
	[char]'К' = "K"
	[char]'л' = "l"
	[char]'Л' = "L"
	[char]'м' = "m"
	[char]'М' = "M"
	[char]'н' = "n"
	[char]'Н' = "N"
	[char]'о' = "o"
	[char]'О' = "O"
	[char]'п' = "p"
	[char]'П' = "P"
	[char]'р' = "r"
	[char]'Р' = "R"
	[char]'с' = "s"
	[char]'С' = "S"
	[char]'т' = "t"
	[char]'Т' = "T"
	[char]'у' = "u"
	[char]'У' = "U"
	[char]'ф' = "f"
	[char]'Ф' = "F"
	[char]'х' = "kh"
	[char]'Х' = "Kh"
	[char]'ц' = "ts"
	[char]'Ц' = "Ts"
	[char]'ч' = "ch"
	[char]'Ч' = "Ch"
	[char]'ш' = "sh"
	[char]'Ш' = "Sh"
	[char]'щ' = "shch"
	[char]'Щ' = "Shch"
	[char]'ю' = "yu"
	[char]'Ю' = "Yu"
	[char]'я' = "ya"
	[char]'Я' = "Ya"
	}
	$outChars=""
	foreach ($c in $inChars = $inString.ToCharArray())
		{
		if ($Translit_To_LAT[$c] -cne $Null ) 
			{$outChars += $Translit_To_LAT[$c]}
		else
			{$outChars += $c}
		}
	Write-Output $outChars
 }
 function global:TranslitToLatUSA # http://transliteration.ru/gosdep/
{
 	param([string]$inString)
	$Translit_To_LAT = @{ 
	[char]'а' = "a"
	[char]'А' = "A"
	[char]'б' = "b"
	[char]'Б' = "B"
	[char]'в' = "v"
	[char]'В' = "V"
	[char]'г' = "g"
	[char]'Г' = "G"
	[char]'д' = "d"
	[char]'Д' = "D"
	[char]'е' = "e"
	[char]'Е' = "E"
	[char]'ж' = "zh"
	[char]'Ж' = "Zh"
	[char]'з' = "z"
	[char]'З' = "Z"
	[char]'и' = "i"
	[char]'И' = "I"
	[char]'Й' = "y"
	[char]'й' = "Y"
	[char]'к' = "k"
	[char]'К' = "K"
	[char]'л' = "l"
	[char]'Л' = "L"
	[char]'м' = "m"
	[char]'М' = "M"
	[char]'н' = "n"
	[char]'Н' = "N"
	[char]'о' = "o"
	[char]'О' = "O"
	[char]'п' = "p"
	[char]'П' = "P"
	[char]'р' = "r"
	[char]'Р' = "R"
	[char]'с' = "s"
	[char]'С' = "S"
	[char]'т' = "t"
	[char]'Т' = "T"
	[char]'у' = "u"
	[char]'У' = "U"
	[char]'ф' = "f"
	[char]'Ф' = "F"
	[char]'х' = "kh"
	[char]'Х' = "Kh"
	[char]'ц' = "ts"
	[char]'Ц' = "Ts"
	[char]'ч' = "ch"
	[char]'Ч' = "Ch"
	[char]'ш' = "sh"
	[char]'Ш' = "Sh"
	[char]'щ' = "shh"
	[char]'Щ' = "Shh"
	[char]'Ъ' = ""
	[char]'ъ' = ""
	[char]'Ы' = "y"
	[char]'ы' = "Y"
	[char]'Ь' = ""
	[char]'ь' = ""
	[char]'э' = "e"
	[char]'Э' = "E"
	[char]'ю' = "yu"
	[char]'Ю' = "Yu"
	[char]'я' = "ya"
	[char]'Я' = "Ya"
	}
	$outChars=""
	foreach ($c in $inChars = $inString.ToCharArray())
		{
		if ($Translit_To_LAT[$c] -cne $Null ) 
			{$outChars += $Translit_To_LAT[$c]}
		else
			{$outChars += $c}
		}
	Write-Output $outChars
 }
  function global:TranslitToLatIso9 # http://transliteration.ru/iso-9-1995/
{
 	param([string]$inString)
	$Translit_To_LAT = @{ 
	[char]'а' = "a"
	[char]'А' = "A"
	[char]'б' = "b"
	[char]'Б' = "B"
	[char]'в' = "v"
	[char]'В' = "V"
	[char]'г' = "g"
	[char]'Г' = "G"
	[char]'д' = "d"
	[char]'Д' = "D"
	[char]'е' = "e"
	[char]'Е' = "E"
	[char]'Ё' = "Ë"
	[char]'ё' = "ё"
	[char]'ж' = "ž"
	[char]'Ж' = "Ž"
	[char]'з' = "z"
	[char]'З' = "Z"
	[char]'и' = "i"
	[char]'И' = "I"
	[char]'Й' = "J"
	[char]'й' = "j"
	[char]'к' = "k"
	[char]'К' = "K"
	[char]'л' = "l"
	[char]'Л' = "L"
	[char]'м' = "m"
	[char]'М' = "M"
	[char]'н' = "n"
	[char]'Н' = "N"
	[char]'о' = "o"
	[char]'О' = "O"
	[char]'п' = "p"
	[char]'П' = "P"
	[char]'р' = "r"
	[char]'Р' = "R"
	[char]'с' = "s"
	[char]'С' = "S"
	[char]'т' = "t"
	[char]'Т' = "T"
	[char]'у' = "u"
	[char]'У' = "U"
	[char]'ф' = "f"
	[char]'Ф' = "F"
	[char]'х' = "kh"
	[char]'Х' = "Kh"
	[char]'ц' = "c"
	[char]'Ц' = "C"
	[char]'ч' = "č"
	[char]'Ч' = "Č"
	[char]'ш' = "š"
	[char]'Ш' = "Š"
	[char]'щ' = "ŝ"
	[char]'Щ' = "Ŝ"
	[char]'Ъ' = ""
	[char]'ъ' = ""
	[char]'Ы' = "y"
	[char]'ы' = "y"
	[char]'Ь' = ""
	[char]'ь' = ""
	[char]'э' = "È"
	[char]'Э' = "è"
	[char]'ю' = "û"
	[char]'Ю' = "Û"
	[char]'я' = "â"
	[char]'Я' = "Â"
	}
	$outChars=""
	foreach ($c in $inChars = $inString.ToCharArray())
		{
		if ($Translit_To_LAT[$c] -cne $Null ) 
			{$outChars += $Translit_To_LAT[$c]}
		else
			{$outChars += $c}
		}
	Write-Output $outChars
 }

function global:TranslitToISO2000 # http://transliteration.ru/gost-7-79-2000/
{
 	param([string]$inString)
	$Translit_To_LAT = @{ 
	[char]'а' = "a"
	[char]'А' = "A"
	[char]'б' = "b"
	[char]'Б' = "B"
	[char]'в' = "v"
	[char]'В' = "V"
	[char]'г' = "g"
	[char]'Г' = "G"
	[char]'д' = "d"
	[char]'Д' = "D"
	[char]'е' = "e"
	[char]'Е' = "E"
	[char]'Ё' = "o"
	[char]'ё' = "Yo"
	[char]'ж' = "zh"
	[char]'Ж' = "Zh"
	[char]'з' = "z"
	[char]'З' = "Z"
	[char]'и' = "i"
	[char]'И' = "I"
	[char]'Й' = "J"
	[char]'й' = "j"
	[char]'к' = "k"
	[char]'К' = "K"
	[char]'л' = "l"
	[char]'Л' = "L"
	[char]'м' = "m"
	[char]'М' = "M"
	[char]'н' = "n"
	[char]'Н' = "N"
	[char]'о' = "o"
	[char]'О' = "O"
	[char]'п' = "p"
	[char]'П' = "P"
	[char]'р' = "r"
	[char]'Р' = "R"
	[char]'с' = "s"
	[char]'С' = "S"
	[char]'т' = "t"
	[char]'Т' = "T"
	[char]'у' = "u"
	[char]'У' = "U"
	[char]'ф' = "f"
	[char]'Ф' = "F"
	[char]'х' = "kh"
	[char]'Х' = "Kh"
	[char]'ц' = "c"
	[char]'Ц' = "C"
	[char]'ч' = "ch"
	[char]'Ч' = "Ch"
	[char]'ш' = "sh"
	[char]'Ш' = "Sh"
	[char]'щ' = "shh"
	[char]'Щ' = "Shh"
	[char]'Ъ' = ""
	[char]'ъ' = ""
	[char]'Ы' = "Y"
	[char]'ы' = "y"
	[char]'Ь' = ""
	[char]'ь' = ""
	[char]'э' = "e"
	[char]'Э' = "E"
	[char]'ю' = "yu"
	[char]'Ю' = "Yu"
	[char]'я' = "ya"
	[char]'Я' = "Ya"
	}
	$outChars=""
	foreach ($c in $inChars = $inString.ToCharArray())
		{
		if ($Translit_To_LAT[$c] -cne $Null ) 
			{$outChars += $Translit_To_LAT[$c]}
		else
			{$outChars += $c}
		}
	Write-Output $outChars
 }

 
  foreach($line in Get-Content $fpathIn)  # перебор файла по строкам
     {    

        if($TraslitSchema -eq "ua") # выбран параметр UA
              {
                $obg = TranslitToUALAT($line)
              }

        elseif($TraslitSchema -eq "ru") # выбран параметр TraslitSchema =ru
              {
                $obg = TranslitToISO2000($line)
              }
        elseif($TraslitSchema -eq "usa") # выбран параметр TraslitSchema =usa
              {
                $obg = TranslitToLatUSA($line)
              }
        elseif($TraslitSchema -eq "iso9") # выбран параметр TraslitSchema =iso9
              {
                $obg = TranslitToLatIso9($line)
              }
        else                               # выбран параметр TraslitSchema =Default
              {
                $obg = TranslitToISO2000($line) 
              }
      
                  
             $obg  |Out-File C:\Script\Translit.translate -append
     }        