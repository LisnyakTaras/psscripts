1)#Вывести список всех сотрудников Отдела Технической поддержки службы ИТ
Get-ADUser -Filter {Department -eq "отдел технической поддержки"}

#2)Вывести список всех сотрудников Отдела Технической поддержки службы ИТ, у укого учетная запись не заблокирована
Get-ADUser -Filter {Department -eq "отдел технической поддержки" -and Enabled -eq "true"}

#3)Вывести список всех сотрудников Отдела Технической поддержки службы ИТ, у укого учетная запись не заблокирована + имя компьютера из AD
Get-ADUser -Filter {Department -eq "отдел технической поддержки" -and Enabled -eq "true"} -Properties WWWHomePage | FT Name,Enabled, wWWHomePage

#4)Вывести количество сотрудников Компании АТБ-Маркет
Get-ADUser -Filter {company -eq "ООО `"АТБ-маркет`""} | Measure-Object

#5)Вывести список номеров телефонов из AD у всех сотрудников Отдела Технической поддержки службы ИТ ( реализовать либо по логину либо по фамилии)
Get-ADUser -Filter {Department -eq "отдел технической поддержки" -and Enabled -eq "true"} -Properties telephoneNumber, Mobile, MobilePhone | FT Name, telephoneNumber, Mobile, MobilePhone