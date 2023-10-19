from prettytable import PrettyTable
import mysql.connector
from PIL import Image, ImageOps
import io

# establish database connection
db = mysql.connector.connect(
    host="localhost", #may need to modify depending on your host
    user="root", #may need to modify depending on the name
    password="aY2002Ma", #may need to modify depending on your server password
    database="valorant-lineups",
)
cursor = db.cursor() # Create a cursor object

AGENT_ROLES = ['Initiator', 'Controller', 'Sentinel', 'Duelist']
LINEUP_TYPES = ['defense', 'attack', 'post-plant', 'setup']
LINEUP_SITES = ['A', 'B', 'C']
INNAPPROPRIATE_WORDS = ['fudge', 'macaroni'] #these are temprory place holder words

agentListQuery = '''
    SELECT agent_name
    FROM agents
'''
cursor.execute(agentListQuery)
agentList = [row[0] for row in cursor]

mapListQuery = '''
    SELECT map_name
    FROM maps
'''
cursor.execute(mapListQuery)
mapList = [row[0] for row in cursor]

#Global Variables to use
isAdmin = False
loggedIn = False
username = None

def main():
    global isAdmin, loggedIn, username
    homeScreen()
    # Close the cursor and connection
    cursor.close()
    db.close()

def homeScreen():
    while True:
        print('Hello and welcome to the valorant lineup database!')
        print('1.) Login')
        print('2.) Signup')
        print('3.) Quit')
        homeScreenOption = int(input('Enter which option you would like to do: '))
        if homeScreenOption not in range(1, 4):
            print('INVALID OPTION')
        else:
            break
    if homeScreenOption == 1:
        login()
        if loggedIn:
            if isAdmin:
                adminMenu()
            else:
                menu()
        else:
            homeScreen()
    elif homeScreenOption == 2:
        signup()
    elif homeScreenOption == 3:
        print('Goodbye! Terminating program.')

def menu():
    while True:
        print('Valorant Lineup Database')
        print('1.) Discover lineups')
        print('2.) Post a lineup')
        print('3.) View your posts')
        print('4.) Settings')
        print('5.) Logout')
        option = int(input('Enter which option you would like to do: '))
        if option not in range(1, 6):
            print('INVALID OPTION')
        else:
            break
    if option == 1:
        searchLineups()
        menu()
    elif option == 2:
        postLineup() 
        menu()
    elif option == 3:
        viewPosts() 
        menu()
    elif option == 4:
        settings()
        menu()
    elif option == 5:
        logout()
        homeScreen()

def adminMenu():
    while True:
        print('Valorant Lineup Database')
        print('1.) Discover lineups')
        print('2.) Post a lineup')
        print('3.) View your posts')
        print('4.) Settings')
        print('5.) Logout')
        print('ADMIN CONTROLS')
        print('6.) Delete user')
        print('7.) Modify user')
        print('8.) Delete lineup')
        print('9.) Modify lineup')
        print('10.) Add new agent')
        print('11.) Add new map')
        print('12.) Pull innapropriate content') #This function will give option to pull for lineups or usernames 
        option = int(input('Enter which option you would like to do: '))
        if option not in range(1, 13):
            print('INVALID OPTION')
        else:
            break
    if option == 1:
        searchLineups()
        adminMenu()
    elif option == 2:
        postLineup()
        adminMenu()
    elif option == 3:
        viewPosts()
        adminMenu() 
    elif option == 4:
        settings()
        adminMenu()
    elif option == 5:
        logout()
        homeScreen()
    elif option == 6:
        deleteUser()
        adminMenu()
    elif option == 7:
        modifyUser()
        adminMenu() 
    elif option == 8:
        deleteLineup()
        adminMenu() 
    elif option == 9:
        modifyLineup()
        adminMenu()
    elif option == 10:
        addAgent()
        adminMenu()
    elif option == 11:
        addMap()
        adminMenu()
    elif option == 12:
        getInappropriateContent()
        adminMenu()

def login():
    global isAdmin, loggedIn, username
    username = input('Enter your username: ')
    password = input('Enter your password: ')
    query = '''
        SELECT admin, password
        FROM players
        WHERE username = %s
    '''
    cursor.execute(query, (username,))
    record = cursor.fetchone()
    if record == None:
        print('Invalid username.')
        return False
    if record[1] == password:
        loggedIn = True
        isAdmin = record[0]
        print('Successfully logged in.')
        return True
    else:
        print('Incorrect password.')
        return False
    
def signup():
    global username
    username = str(input('Enter the username you would like: '))
    query = '''
        SELECT *
        FROM players
        WHERE username = %s
    '''
    cursor.execute(query, (username,))
    record = cursor.fetchone()
    if record == None:
        while True:
            password = str(input('Enter the password you would like to use: '))
            confirmPassword = str(input('Re-enter the password to confirm it: '))
            if password != confirmPassword:
                print('Passwords did not match. Make sure to double check it.')
            else:
                break
        #make query to insert new user
        query = '''
            INSERT INTO players(username, password)
            VALUES (%s, %s)
        '''
        cursor.execute(query, (username, password))
        db.commit()
        print('Your account has been made!')
        loggedIn = True
        menu()
    else:
        print('Sorry that username is already taken.')
        homeScreen()

def searchLineups():
    try:
        while True:
            mapName = str(input('Enter the map you would like to search by: '))
            if mapName not in mapList:
                print('Please enter a valid map name: ')
            else:
                break
        while True:
            agentName = str(input('Enter the agent you would like to search by: '))
            if agentName not in agentList:
                print('Please enter a valid agent name: ')
            else:
                break
        possibleAbilityList = []
        query = '''
            SELECT ability_name
            FROM abilities
            WHERE agent_name = %s
        '''
        cursor.execute(query, (agentName,))
        possibleAbilityList = [row[0] for row in cursor]
        print('Here is the list of possible abilities to choose from:', possibleAbilityList)
        while True:
            abilityList = str(input('Enter the list of abilities (seperated by commas) you would like to search by. (put \'ANY\' for all abilities): ')).split()
            if abilityList == ['ANY']:
                abilityList = possibleAbilityList
                break
            validAbilities = True
            for abilityChoice in abilityList:
                if abilityChoice not in possibleAbilityList:
                    print('Not a valid possible ability to choose from.')
                    validAbilties = False
                    break
            if validAbilities:
                break
        #now we can perform the query
        query = '''
            SELECT id
            FROM lineups
            JOIN agent_tags ON lineups.id = agent_tags.lineup_id
            JOIN agents USING (agent_name)
            JOIN ability_tags ON lineups.id = ability_tags.lineup_id
            JOIN abilities USING (ability_name)
            WHERE agents.agent_name = %s AND lineups.map_name = %s AND abilities.ability_name IN ({});
        '''.format(','.join(['%s'] * len(abilityList)))
        values = ([agentName, mapName] + abilityList)
        cursor.execute(query, values)
        lineupIDS = set([row[0] for row in cursor])
        lineupIDS = list(lineupIDS)
        if len(lineupIDS) == 0:
            print('Sorry. There are no lineups in our database that match your given tags.')
        else:
            for lineupID in lineupIDS:
                printLineupInfo(lineupID)
            lineupMenu(lineupIDS)
    except Exception as e:
        print('Something went wrong.')

def printLineupInfo(id): #helper function for displaying a lineup and its info
    print('==================================================================================================================================')
    print('||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||')
    print('==================================================================================================================================')
    print(f'Lineup #{id} Info')
    query = '''
        SELECT video, username, date, type, site, map_name, difficulty
        FROM lineups
        WHERE id = %s
    '''
    cursor.execute(query, (id,))
    table = PrettyTable()
    for row in cursor:
        table.field_names = ['Link', 'username', 'date', 'type', 'site', 'map', 'difficulty', 'average rating']
        table.add_row([row[0], row[1], str(row[2]), row[3], row[4], row[5], row[6], averageRating(id)])
        print(table)
    #query to print the list of agents tagged under this lineup
    print('-----------------------------------------------------------------')
    print('Agents')
    print('-----------------------------------------------------------------')
    query = '''
        SELECT agents.agent_name, agent_image
        FROM agents
        JOIN agent_tags USING (agent_name)
        WHERE agent_tags.lineup_id = %s
    '''
    cursor.execute(query, (id,))
    for row in cursor:
        if row[0] == 'KAY/O':
            fileName = 'kayo'
        else:
            fileName = row[0]
        agentIcon = Image.open(io.BytesIO(row[1]))
        file_path = f'ProgramSavedAssets/{fileName}icon.webp'
        agentIcon.save(file_path)
        image_link = 'file://' + file_path
        print(row[0], image_link)
    print('-----------------------------------------------------------------')
    print('Abilities')
    print('-----------------------------------------------------------------')
    query = '''
        SELECT abilities.ability_name, ability_image
        FROM abilities
        JOIN ability_tags USING (ability_name)
        WHERE ability_tags.lineup_id = %s
    '''
    cursor.execute(query, (id,))
    for row in cursor:
        if row[0] == 'FRAG/MENT':
            fileName = 'fragment'
        elif row[0] == 'FLASH/DRIVE':
            fileName = 'flashdrive'
        elif row[0] == 'ZERO/POINT':
            fileName = 'zeropoint'
        else:
            fileName = row[0]
        agentIcon = Image.open(io.BytesIO(row[1]))
        file_path = f'ProgramSavedAssets/{fileName}icon.webp'
        agentIcon.save(file_path)
        image_link = 'file://' + file_path
        print(row[0], image_link)
    print('==================================================================================================================================')
    print('||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||')
    print('==================================================================================================================================')

def averageRating(id): #calculates the average rating for a lineup
    query = '''
        SELECT AVG(rating)
        FROM ratings
        WHERE lineup_id = %s
    '''
    cursor.execute(query, (id,))
    return cursor.fetchone()[0]

def lineupMenu(ids):
    while True:
        print('1.) Rate a lineup')
        print('2.) Report a lineup')
        print('3.) Save a lineup')
        print('4.) Back to main menu')
        lineupOption = int(input('Enter which option you would like to do: '))
        if lineupOption not in range(1, 5):
            print('INVALID OPTION')
        else:
            break
    if lineupOption == 1:
        while True:
            rateID = int(input('Which lineup ID would you like to rate?: '))
            if rateID not in ids:
                print('Not a valid id to report right now.')
            else:
                break
        while True:
            ratingMade = int(input('How would you rate the lineup on a scale from (1-5)?: '))
            if ratingMade not in range(1, 6):
                print('Not a valid rating.')
            else:
                break
            query = 'INSERT INTO ratings VALUES (%s, %s, %s)'
            cursor.execute(query, (rateID, username, ratingMade))
            db.commit()
            print('Your review has been made.')
    elif lineupOption == 2:
        while True:
            reportID = int(input('Which lineup ID would you like to report for innacurate info?: '))
            if reportID not in ids:
                print('Not a valid id to report right now.')
            else:
                break
        query = '''
            UPDATE lineups
            SET review_flag = true
            WHERE id = %s
        '''
        cursor.execute(query, (reportID,))
        db.commit()
        print('You report has been made. Thank you!')
    elif lineupOption == 3:
        while True:
            saveID = int(input('Which lineup ID would you like to save?: '))
            if saveID not in ids:
                print('Not a valid id to save right now.')
            else:
                break
        query = 'INSERT saves (lineup-id, username) VALUES (%s, %s)'
        cursor.execute(query, (saveID, username))
    elif lineupOption == 4:
        pass

def postLineup():
    videoLink = str(input('Paste in the video link into here: '))
    while True:
        mapName = str(input('Enter the name of the map for this lineup: '))
        if mapName not in mapList:
            print('Not a valid map.')
        else:
            break
    while True:
        agentName = str(input('Enter the name of the agent for this lineup: '))
        if agentName not in agentList:
            print('Not a valid map.')
        else:
            break

    possibleAbilityList = []
    query = '''
        SELECT ability_name
        FROM abilities
        WHERE agent_name = %s
    '''
    cursor.execute(query, (agentName,))
    possibleAbilityList = [row[0] for row in cursor]
    print('Here is the list of possible abilities to choose from:', possibleAbilityList)
    while True:
        abilityList = str(input('Enter the list of abilities (seperated by commas) you would like to tag for your lineup. (put \'ALL\' for all abilities): ')).split()
        if abilityList == ['ALL']:
            abilityList = possibleAbilityList
            break
        validAbilities = True
        for abilityChoice in abilityList:
            if abilityChoice not in possibleAbilityList:
                print('Not a valid possible ability to choose from.')
                validAbilties = False
                break
        if validAbilities:
            break

    while True:
        difficulty = int(input('Enter the difficulty of your lineup on a scale from (1-5): '))
        if difficulty not in range(1, 6):
            print('Not a valid difficulty rating.')
        else:
            break

    while True:
        print('List of possible lineup types to choose from:', LINEUP_TYPES)
        type = str(input('Enter the type of lineup: '))
        if type not in LINEUP_TYPES:
            print('Not a valid lineup type.')
        else:
            break

    while True:
        print('List of possible sites to choose from: ', LINEUP_SITES)
        site = str(input('Enter the site for the lineup: '))
        if site not in LINEUP_SITES:
            print('Not a valid site.')
        else:
            break

    query = '''
        INSERT INTO lineups (video, date, difficulty, type, site, username, map_name)
        VALUES (%s, CURDATE(), %s, %s, %s, %s, %s)
    '''
    cursor.execute(query, (videoLink, difficulty, type, site, username, mapName))
    query = 'INSERT INTO agent_tags (lineup_id, agent_name) VALUES (LAST_INSERT_ID(), %s)'
    cursor.execute(query, (agentName,))
    for ability in abilityList:
        query = 'INSERT INTO ability_tags (lineup_id, ability_name) VALUES (LAST_INSERT_ID(), %s)'
        cursor.execute(query, (ability,))
    db.commit()
    print('Your lineup has successfully been posted!')

def viewPosts():
    query = '''
        SELECT id
        FROM lineups
        WHERE username = %s
    '''
    cursor.execute(query, (username,))
    for row in cursor:
        printLineupInfo(row[0])

def settings():
    global username
    print('Settings')
    print('1.) Change username')
    print('2.) Change password')
    print('3.) Delete lineup')
    while True:
        settingOption = int(input('Enter which option you would like to do: '))
        if settingOption not in range(1, 4):
            print('INVALID OPTION')
        else:
            break
    if settingOption == 1:
        newUsername = str(input('Enter the new username you would like: '))
        try:
            query = '''
                UPDATE players
                SET username = %s
                WHERE username = %s
            '''
            cursor.execute(query, (newUsername, username))
            db.commit()
            username = newUsername
            print('Successfully changed your username.')
        except mysql.connector.IntegrityError as e:
            print('That username is unavailable.')
    elif settingOption == 2:
        while True:
            newPassword = str(input('Enter the new password you would like to use: '))
            confirmNewPassword = str(input('Re-enter the new password to confirm it: '))
            if newPassword != confirmNewPassword:
                print('Passwords did not match. Make sure to double check it.')
            else:
                break
        query = '''
            UPDATE players
            SET password = %s
            WHERE username = %s
        '''
        cursor.execute(query, (newPassword, username))
        db.commit()
        print('Successfully changed password')
    elif settingOption == 3:
        print('Here are your lineups:')
        query = '''
            SELECT id
            FROM lineups
            WHERE username = %s
        '''
        cursor.execute(query, (username,))
        postedLineupIDS = [row[0] for row in cursor]
        while True:
            deleteID = int(input('Enter the id for the lineup you would like to delete: '))
            if deleteID not in postedLineupIDS:
                print('Not a valid id.')
            else:
                break
        query ='DELETE FROM lineups WHERE id = %s'
        cursor.execute(query, (deleteID,))
        db.commit()
        if cursor.rowcount > 0:
            print('Deleted the lineup.')
        else:
            print('Could not find that lineup to delete.')

def logout():
    global isAdmin, loggedIn, username
    isAdmin = False
    loggedIn = False
    username = None
    print('Successfully logged out.')

#ADMIN CONTROLS
def deleteUser():
    usernameToDelete = str(input('Enter the username of a player to delete: '))
    query ='DELETE FROM players WHERE username = %s'
    cursor.execute(query, (usernameToDelete,))
    db.commit()
    if cursor.rowcount > 0:
        print('Deleted the player and their content.')
    else:
        print('Could not find that username to delete.')

def modifyUser():
    pass

def deleteLineup():
    viewPosts()
    lineupIDToDelete = str(input('Enter the lineup ID to delete: '))
    query ='DELETE FROM lineups WHERE id = %s'
    cursor.execute(query, (lineupIDToDelete,))
    db.commit()
    if cursor.rowcount > 0:
        print('Deleted the lineup.')
    else:
        print('Could not find that lineup to delete.')

def modifyLineup():
    pass

def addAgent():
    agentName = str(input('Enter the name of the agent: '))
    while True:
        agentRole = str(input('Enter the role of the agent: '))
        if agentRole not in AGENT_ROLES:
            print('Not a valid agent role.')
        else:
            break
    agentNumber = int(input('Enter the agent number: '))
    try:
        agentImagePath = str(input('Enter the file path for the agent icon image: '))
        query = 'INSERT INTO agents (agent_number, agent_name, role, agent_image) VALUES (%s, %s, %s, LOAD_FILE(%s))'
        agentValues = (agentNumber, agentName, agentRole, agentImagePath)
        cursor.execute(query, agentValues)
        #Now we will create the abilities for the agent
        for i in range(1, 5): #for each ability
            abilityName = str(input(f'Enter ability {i} name for {agentName}: '))
            agentImagePath = str(input('Enter the file path for the ability icon image: '))
            query = 'INSERT INTO abilities (ability_name, ability_no, ability_image, agent_number) VALUES (%s, %s, LOAD_FILE(%s), %s)'
            abilityValues = (abilityName, i, agentImagePath, agentNumber)
            cursor.execute(query, abilityValues)
            print(f'Successfully created ability {i}')
        db.commit()
        print('The agent and its abilities has successfully been created')
    except Exception as e:
        print('Something went wrong when trying to create the agent.')

def addMap():
    mapName = str(input('Enter the name of the map: '))
    mapImagePath = str(input('Enter the file path for the map image: '))
    query = 'INSERT INTO maps (map_name, map_image) VALUES (%s, LOAD_FILE(%s))'
    mapValues = (mapName, mapImagePath)
    try:
        cursor.execute(query, mapValues)
    except Exception as e:
        print('Something went wrong when trying to create the map.')

def getPlayers(): #gets the username of each player
    query = '''
        SELECT username
        FROM players
    '''
    cursor.execute(query)
    return [row[0] for row in cursor]

def showAgentIcons():
    query = '''
        SELECT agent_image
        FROM agents
    '''
    cursor.execute(query)
    record = cursor.fetchone()
    while record is not None:
        image = Image.open(io.BytesIO(record[0]))
        image.show()
        record = cursor.fetchone()

def getInappropriateContent():
    while True:
        specifyOption = str(input('Which would you like to pull for? (username/lineup): '))
        if specifyOption not in ['username', 'lineup']:
            print('Not a valid option.')
        else:
            break
    if specifyOption == 'username':
        innappropriateUsernames = []
        for badWord in INNAPPROPRIATE_WORDS:
            print(badWord)
            query = 'SELECT username FROM players WHERE username LIKE %s'
            cursor.execute(query, ('%' + badWord + '%',))
            innappropriateUsernames += [row[0] for row in cursor]
        print('Here is a list of innapropriate usernames: ', set(innappropriateUsernames))
    elif specifyOption == 'lineup':
        query = 'SELECT id FROM lineups WHERE review_flag = TRUE'
        cursor.execute(query)
        print('Here are the lineups that have been flagged for review:')
        for row in cursor:
            print(row[0])
            printLineupInfo(row[0])

if __name__ == '__main__':
    main()