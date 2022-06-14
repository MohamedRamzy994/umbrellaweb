using System;
using System.Collections.Generic;


#region Enums
public enum _OnesEnum
{
    One = 1, Tow, Three, Four, Five, Six, Seven, Eight, Nine
}

public enum _TwosEnum
{
    Eleven = 1, Tweleve, Thirteen, Fourteen, Fifteen, Sixteen, Seventeen, eighteen, nineteen
}

public enum _HunEnum
{
    Ten = 1, Twenty, Thirty, Fourty, Fifty, Sixty, Seventy, Eighty, Ninety
}

#endregion

public class EnConverter_ud
{
    List<string> list = new List<string>() { "", "Thouthand", "Milion", "Bilion" };

    public string Ones(string number)
    {
        if (number[0] == '1')
        {
            return Convert.ToString((_TwosEnum)int.Parse(number[number.Length - 1].ToString()));
        }
        else if (number.Length == 1)
        {
            return Convert.ToString((_OnesEnum)int.Parse(number[0].ToString()));
        }
        else
        {
            var text = Convert.ToString((_HunEnum)int.Parse(number[0].ToString()) + " " + (_OnesEnum)int.Parse(number[1].ToString()));
            return text;
        }
    }

    public string GetTows(string _number, string Type)
    {
        if (_number.Length % 2 != 0)
            return String.Format("{0} {1}", Convert.ToString((_OnesEnum)int.Parse(_number[0].ToString())), Type);
        else
            return String.Format("{0} {1}", Ones(_number.Substring(0, 2)), Type);
    }

    public string Single(string number)
    {
        var first = "";
        var second = "";
        if (number.Length > 2)
        {
            first = GetTows(number, "Hundered");
        }
        second = (number.Length > 2) ? Ones(number.Substring(1, 2)) : Ones(number.Substring(0, number.Length));

        return first + " " + second;
    }

    public int SetText(string text)
    {
        return text.Length / 3;
    }

    public string SplitText(string text, string result)
    {
        string[] arr = new string[2];
        if (text.Contains("."))
        {
            arr = text.Split('.');

            result = ConvertText(arr[0], SetText(arr[0]), result: "") + " $ and " + ConvertText(arr[1], SetText(arr[1]), result: "") + " Sent";

            return result;
        }
        else
        {
            return ConvertText(text, SetText(text), result: "");
        }
    }

    public string TextConverer(string text, string result)
    {
        var outPut = SplitText(text, result)
            .Replace("0Milion", "")
            .Replace("0 Thouthand", "")
            .Replace("0 Hundered", "0")
            .Replace("0", "");
        return outPut;
    }

    public string ConvertText(string text, int loop, string result)
    {
        if (loop > 2)
        {
            for (int i = loop; i > 0; i--)
            {
                result += Single(text.Substring(text.Length - (i * 3), 3)) + list[i - 1] + ",";
            }
        }
        else
        {
            result = Single(text);
        }
        return result;
    }
}
