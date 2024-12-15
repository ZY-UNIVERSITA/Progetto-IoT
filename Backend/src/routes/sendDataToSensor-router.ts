import { Router } from "express";
import * as sendDataController from "../controllers/send-data-controller";

const router: Router = Router();

router.post("/api/modifier/limit", sendDataController.modify_limit)

export default router;