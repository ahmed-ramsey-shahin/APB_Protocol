import os

envs = ['master', 'slave']

folders = {
        'master': 'APB_Master_env/',
        'slave': 'APB_Slave_env/'
}

classes = [
    'agent',
    'config',
    'coverage',
    'driver',
    'env',
    'interface',
    'rst_seq',
    'main_seq',
    'monitor',
    'scoreboard',
    'seq_item',
    'sequencer',
    'shared_pkg',
    'sva',
    'test',
    'top',
]

for env in envs:
    for class_ in classes:
        with open(os.path.join(folders[env], f'{env}_{class_}.sv'), 'w'):
            pass
