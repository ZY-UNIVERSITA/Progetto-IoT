import { Router } from "express";
import * as sendDataController from "../controllers/send-data-to-sensor-controller";

const router: Router = Router();

router.post("/api/modifier/limit/:sensor_id", sendDataController.modify_limit)
router.get("/api/modifier/test", sendDataController.modify_lim)

export default router;