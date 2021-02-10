import multer from 'multer';
import {v4 as uuid} from 'uuid';
import path from 'path';
import fs from 'fs';
import debugLib from 'debug';

const debug = debugLib('AppKinson:PersonService');

const storage = multer.diskStorage({
    destination: (req, file, callback) => {
        debug('destination file');
        let pathToSave = '';
        if(file.fieldname === 'video' ) {
            pathToSave = `uploads/video`;
        } else {
            pathToSave = `uploads/photo`;
        }
        debug('destination path: %s', pathToSave);
        if (!fs.existsSync(pathToSave)) fs.mkdirSync(pathToSave, { recursive: true });
        callback(null, pathToSave);
    },
    filename:(req, file, cb) => {
        cb(null, uuid() + path.extname(file.originalname));
    }
});

export default multer({storage});