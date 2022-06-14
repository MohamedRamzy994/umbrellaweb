using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Microsoft.AspNet.SignalR;

public class MyHub1 : Hub
{
    public void Withdrawals()
    {
        Clients.Others.doSomething();
    }
    public void Encashment()
    {
        Clients.All.doSomething();
    }        
    
}
