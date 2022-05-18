using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace ipt101_gallery_project.Helpers
{
    public class Numbers
    {
        public static sbyte Clamp<T>(T _self, T _min, T _max)
        {
            var self = sbyte.Parse(_self.ToString());
            var max = sbyte.Parse(_max.ToString());
            var min = sbyte.Parse(_min.ToString());


            return Math.Min(max, Math.Max(self, min));
        }
    }
}