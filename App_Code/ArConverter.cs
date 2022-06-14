using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

public class ArConverter_ud
{
    public int loop = 0;
    public Stack<string> _Result = new Stack<string>();

    #region Data
    string[] _Tows = new string[]
            {
                "0","مائة", "مئتان", " ثلاثمئة ",
                "أربعمئة", "خمسمئة", "ستمئة",
                "سبعمئة ", "ثمانمئة ", "تسعمئة"
            };
    string[] _Owns = new string[] 
            { 
                "0","واحد ", "اثنان ", "ثلاثة",
                "أربعة ", "خمسة ", "ستة", 
                "سبعة ", "ثمانية ", "تسعة "
            };

    string[] _TensNumber = new string[]
            {
                "","0","عشرون","ثلاثون","أربعون","خمسون","ستون","سبعون","ثمانون","تسعون"
            };

    string[] _ThouthandNumber = new string[]
            {
                "ألف","ألفان","ألوف"
            };

    string[] _CompilationNumber = new string[] 
            { 
                "عشرة ", "أحد عشر,", "اثنتا عشرة ",
                "ثلاثة عشر ", "أربعة عشر ", "خمسة عشر ",
                "ستة عشر ", "شبعة عشر ", "ثمانية عشر ", "تسعة عشر "
            };

    string[] _Distinction = new string[]
        {
            "","ألف و","مليون و","تريليون و"
        };
    #endregion

    
    public int GetIterator(string item)
    {
        var length = item.Length / 3;

        if (item.Length % 3 != 0)
            return length + 1;
        else
            return (item.Length / 3);
    }

    public string GetResult(int iterator, string item)
    {
        string result = " ";
        for (int i = iterator; i > 0; i--)
        {
            var index = (item.Length % 3 == 0) ?
                item.Length - ((item.Length / iterator) * ((iterator - i + 1) % (iterator * iterator))) :
                2 * i + (-1 * (((i * i) % iterator) + 1));

            var _long = (index != 0 || item.Length % 3 == 0) ? 3 : item.Length % 3;

            result = GetText(item.Substring(index, _long)) + " " + _Distinction[loop++] + " ";
            _Result.Push(result);
        }
        return result;
    }

    public string GetText(string Text)
    {
        int first = int.Parse(Text[0].ToString());
        int second = (Text.Length >= 2) ? int.Parse(Text[1].ToString()) : 0;
        int third = 0;
        if (Text.Length > 2)
        {
            second = (String.IsNullOrEmpty(Text[1].ToString())) ? 0 : int.Parse(Text[1].ToString());
            third = (String.IsNullOrWhiteSpace((Text[2].ToString())) ? 0 : int.Parse(Text[2].ToString()));

            if (second == 1)
            {
                if (first == 0)
                    return _Tows[first] + " و " + _CompilationNumber[third];
                else
                    return _Tows[first - 1] + " و " + _CompilationNumber[third];
            }
            else
                return _Tows[first] + " و " + _Owns[third] + " و  " + _TensNumber[second];
        }
        else
        {
            if (first == 1)
                return _CompilationNumber[second];
            else
                return _Owns[second] + " و  " + _TensNumber[first];
        }


    }

    public string SplitText(string text)
    {
        string[] arr = new string[2];
        string result = "";

        if (text.Contains("."))
        {
            arr = text.Split('.');

            result = " قرش" + GetResult(GetIterator(arr[1]), arr[1]) + " جنيه و " + GetResult(GetIterator(arr[0]), arr[0]);

            return result;
        }
        else
        {
            return GetResult(GetIterator(text), text);
        }
    }

    public string Convert(string item)
    {
        //var result = GetResult(GetIterator(item), item);
        var result = SplitText(item);
        var finalResult = "";
        foreach (var sent in _Result)
        {
            var filter = sent.Replace("و ", "").Replace("0و", "").Replace("0 0", "").Replace("0", "و");
            finalResult += filter;
        }
        return finalResult;
    }
}

