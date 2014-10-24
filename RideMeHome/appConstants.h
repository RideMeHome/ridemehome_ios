//
//  appConstants.h
//  DevconApp14
//
//  Created by ajith kumar on 7/25/14.
//  Copyright (c) 2014 AJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface appConstants : NSObject
{
    
}



//// prod build url

//#define BASE_URL  @"https://events.ucern.com/webservices/"

#define BASE_URL @"https://eventscrt.ucern.com/webservices/"

//#define BASE_URL @"https://buildevents.cerner.com/webservices/"

//#define BASE_URL @"http://WIN7B-103-00134:8080/webservices/"

#define LOGIN_URL  @"authenticate/associate"

#define SESSIONS_URL @"events/allSessions?eventId=event201405281101131828389597"

#define USERAGENDA_URL @"events/userAgenda?eventId=event201405281101131828389597&personId="

#define PROFILEIMG_URL @"events/getImage?associateId="

#define NEWS_URL @"events/getEventNews?eventId=event201405281101131828389597"





#define GENERAL_INFO 200001

#define SCHEDULE_INFO 200002

#define MYSCHEDULE_INFO 200003

#define NEWS_INFO 200004

#define MAP_INFO 200005

#define FAQ_INFO 200006

#define POST_REQUEST 30001

#define GET_REQUEST 30002



///// list of commands

#define COMMAND_LOGIN 10001

#define COMMAND_ALLSESSIONS 10002

#define COMMAND_MYSESSIONS 10003

#define COMMAND_NEWS 10004


//// list of local notification identifiers.

#define NOTIFY_LOGIN @"notifylogin"

#define NOTIFY_LOGOUT @"notifylogout"

//// list of cached data keys


#define KEY_USERDATA @"userdata"

#define KEY_ALLSESSIONDATA @"allsessions"

#define KEY_MYSESSIONDATA @"myagenda"

#define KEY_NEWSDATA @"newsdata"



///// strings and error messages

#define LOGIN_CANCEL_TITLE @"Login Required"

#define LOGIN_CANCEL_MESSAGE @"Login to access the information"

#define SESSION_NOT_AVAIL @"There is no session information available"

#define NEWS_NOTAVAILABLE @"News not available"

@end
