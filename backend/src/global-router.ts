import { Router } from "express";
import authRouter from "./auth/auth-router";
import kazllm_router from "./kazllm/kazllm-router";
// other routers can be imported here

const globalRouter = Router();

globalRouter.use(authRouter);
globalRouter.use(kazllm_router);

export default globalRouter;
