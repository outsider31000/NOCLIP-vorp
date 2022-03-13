Config = {
    Locale = 'en',

    Controls = {
        
        openKey =  0x4AF4D473, -- DEL
        goUp = 0xDE794E3E, -- Q
        goDown = 0x26E9DC00, -- Z
        turnLeft = 0x7065027D, -- A
        turnRight = 0xB4E465B4, -- D
        goForward = 0x8FD015D8,  -- W
        goBackward = 0xD27782E3, -- S
        changeSpeed = 0x8FFC75D6, -- L-Shift
        camMode = 0x24978A28, -- H
    },

    Speeds = {
        -- You can add or edit existing speeds with relative label
        { label = 'Very Slow', speed = 0},
        { label = 'Slow', speed = 0.5},
        { label = 'Normal', speed = 2},
        { label = 'Fast', speed = 10},
        { label = 'Very Fast', speed = 15},
        { label = 'Max', speed = 29},
    },

    Offsets = {
        y = 0.2, -- Forward and backward movement speed multiplier
        z = 0.1, -- Upward and downward movement speed multiplier
        h = 1, -- Rotation movement speed multiplier
    },

    VORP = true, 
    FrozenPosition = true, 
    AllowedGroups = {
        'admin',
    },

    AllowedSteamIDs = {
        'steam:1100001335513c4', 
    },
}