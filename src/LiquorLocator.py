'''
Created on Jun 2, 2016

@author: KJNETHER
'''
import requests  

class RouteLiquor(object):
    
    def __init__(self, points):
        self.points = points
        self.routerUrl = 'https://routertst.api.gov.bc.ca/'
        self.routeToken = '539058c1a33e47d982df47c964788d6c'
        if self.routerUrl[-1] == '/':
            self.routerUrl = self.routerUrl[:-1]
        self.returnFormat = 'json'
        self.initialRoute = None
        
    def getRoute(self, points=None):
        if not points:
            points = self.points
        print 'self.points', self.points
        # convert points to strings
        strPnt = []
        for pnt in points:
            strPnt.append(str(pnt))
        #points = '{0},{1}'.format(location1,location2 )
        routeUrl = self.routerUrl + r'/route.' + self.returnFormat
        params = {'points': ','.join(strPnt), 
                  'criteria':'fastest',
                  'distanceUnit':'km',
                  'apikey':self.routeToken}
        print 'routeUrl', routeUrl
        request = requests.get(routeUrl, params=params, verify=False)
        print 'request', request
        self.initialRoute = request.json()
        print self.initialRoute
        
    def getBB(self, buffer=None):
        if not self.initialRoute:
            self.getRoute()
        minX = 0
        minY = 0
        maxX = 0
        maxY = 0
        for point in self.initialRoute['route']:
            if not minX:
                minX = point[0]
                maxX = point[0]
                minY = point[1]
                minY = point[1]
            else:
                if point[0] <  minX:
                    minX =  point[0]
                if point[0] > maxX:
                    maxX = point[0]
                if point[1] < minY:
                    minY = point[1]
                if point[1] > minY:
                    maxY = point[1]
        bb = [minX, minY, maxX, maxY]
        print bb
        return [minX, minY, maxX, maxY]
    
    
    
                    
            
        

if __name__ == '__main__':
    testpoints = [-126.844567, 49.9785, -122.799997, 58.925305]
    rl = RouteLiquor(testpoints)
    rl.getRoute()
    rl.getBB()
        
        