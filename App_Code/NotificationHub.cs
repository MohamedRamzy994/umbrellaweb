using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Microsoft.AspNet.SignalR;

public class NotificationHub : Hub
{
    public void SendNotification()
    {
        Clients.All.recieveNotification();
    }        
}
