import { Router } from "express";
import * as sensorRouter from "../controllers/sensor-controller";

const router: Router = Router();

router.get("/api/sensor/:id", sensorRouter.getSensor)
router.get("/api/getAllSensors", sensorRouter.getAllSensors)

export default router;