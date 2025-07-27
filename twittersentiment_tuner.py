from keras_tuner import RandomSearch, HyperParameters
from tfx.dsl.components.common.tuner_fn_result import TunerFnResult
from tfx.components.trainer.fn_args_utils import FnArgs
print(">>> DEBUG: diabetesdetection_tuner.py berhasil diimport oleh TFX <<<")
def build_model(hp):
    import tensorflow as tf
    model = tf.keras.Sequential([
        tf.keras.layers.Dense(hp.Int('units', 32, 128, step=32), activation='relu'),
        tf.keras.layers.Dense(3, activation='softmax')  # <- 3 kelas
    ])
    model.compile(optimizer='adam', loss='sparse_categorical_crossentropy', metrics=['accuracy'])
    return model

def tuner_fn(fn_args: FnArgs) -> TunerFnResult:
    hp = HyperParameters()
    tuner = RandomSearch(
        build_model,
        max_trials=10,
        hyperparameters=hp,
        objective='val_accuracy',
        directory=fn_args.working_dir,
        project_name='tune_diabetes'
    )
    return TunerFnResult(tuner=tuner, fit_kwargs={})
